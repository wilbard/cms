package com.clk.cms.mgt

import com.clk.cms.Role
import com.clk.cms.User
import com.clk.cms.UserDetails
import com.clk.cms.UserRole
import grails.gorm.transactions.Transactional
import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import org.grails.web.json.JSONObject
import org.springframework.web.bind.annotation.RequestBody

import java.sql.Timestamp

import static org.springframework.http.HttpStatus.*

@Secured(['ROLE_ADMIN', 'ROLE_MANAGER', 'ROLE_STAFF'])
class ComplaintController {

    ComplaintService complaintService
    def springSecurityService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond complaintService.list(params), model:[complaintCount: complaintService.count()]
    }

    def show(Long id) {
        respond complaintService.get(id)
    }

    def create() {
        respond new Complaint(params)
    }

    def save(Complaint complaint) {
        if (complaint == null) {
            notFound()
            return
        }

        try {
            complaintService.save(complaint)
        } catch (ValidationException e) {
            respond complaint.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'complaint.label', default: 'Complaint'), complaint.id])
                redirect complaint
            }
            '*' { respond complaint, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond complaintService.get(id)
    }

    def update(Complaint complaint) {
        if (complaint == null) {
            notFound()
            return
        }

        try {
            complaintService.save(complaint)
        } catch (ValidationException e) {
            respond complaint.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'complaint.label', default: 'Complaint'), complaint.id])
                redirect complaint
            }
            '*'{ respond complaint, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        complaintService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'complaint.label', default: 'Complaint'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'complaint.label', default: 'Complaint'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    JSONObject inbox(@RequestBody User userData) {
        def alerts = Escalate.findAllByEscalated_toAndIs_accessed(userData, false, [sort: 'escalated_time', order: 'desc', max: 3])
        int alerts_count = Escalate.countByEscalated_toAndIs_accessed(userData, false)
        JSONObject jsonData = new JSONObject()
        jsonData.put("alerts_count", alerts_count)
        jsonData.put("alerts", alerts)
        return jsonData
    }

    def add_complaint() {
        def departments = Department.list()
        def managers = Manage.list()
        if (params._action_add_complaint) {
            try {
                def calendar_time = Calendar.instance
                Complaint complaintData = new Complaint()
                Escalate escalateData = new Escalate()
                JSONObject complaint_return = new JSONObject()

                if (params.title) {
                    String title = params.title
                    complaintData.title = title
                    complaint_return.put("title", title)
                }
                if (params.manager_id) {
                    String manager_id = params.manager_id
                    escalateData.escalated_to = User.get(Long.parseLong(manager_id))
                    complaint_return.put("manager_id", manager_id)
                }
                if (params.description) {
                    String description = params.description
                    complaintData.description = description
                    complaint_return.put("description", description)
                }

                if (!(params.title && params.manager_id && params.description && params.complainer_id)) {
                    render(view: 'add_complaint', model: [departments: departments, managers: managers, complaint_return: complaint_return, errorMessage: 'Please fill all fields!!'])
                    return
                }

                String managerString = params.manager_id
                UserDetails userDetailsData = UserDetails.findByUser(User.get(Long.parseLong(managerString)))
                complaintData.last_action = "Submitted to " + userDetailsData.full_name
                String complainer_id = params.complainer_id
                complaintData.submitted_by = User.get(Long.parseLong(complainer_id))
                complaintData.status = "Pending"
                complaintData.created_time = new Timestamp(calendar_time.time.time)
                Complaint results = complaintData.save(flash: true, failOnError: true)

                if (results) {
                    escalateData.complaint = results
                    escalateData.escalated_by = User.get(Long.parseLong(complainer_id))
                    escalateData.escalated_time = new Timestamp(calendar_time.time.time)
                    escalateData.is_accessed = false
                    escalateData.is_processed = false
                    if (escalateData.save(flash: true, failOnError: true)) {
                        redirect controller: 'complaint', action: 'complaint_info', params: [complaint_id: results.id]
                    }else {
                        redirect controller: 'complaint', action: 'escalate_complaint', params: [complaint_id: results.id]
                    }
                }

            }catch (Exception e) {
                e.printStackTrace()
            }
        }else {
            render(view: 'add_complaint', model: [departments: departments, managers: managers])
        }
    }

    @Transactional
    def edit_escalation(Escalate escalate) {
        escalate.save()
    }

    def complaint_info(long complaint_id) {
        long user_id = (long) springSecurityService.currentUserId
        def complaintData = Complaint.get(complaint_id)
        Complaint complaint_data = Complaint.get(complaint_id)

        Escalate escalateData = Escalate.findByComplaintAndEscalated_to(complaint_data, User.get(user_id))
        if (escalateData == null) {
            /**escalateData = Escalate.findByComplaintAndEscalated_by(complaint_data, User.get(user_id))*/
        }else {
            escalateData.is_accessed = true
            this.edit_escalation(escalateData)
        }

        render(view: 'complaint_info', model: [complaintData: complaintData])
    }

    def complaints() {
        long user_id = (long) springSecurityService.currentUserId
        int max = 20
        int page_number = 1
        try {
            if (params.page_number) {
                String page_numberString = params.page_number
                page_number = Integer.parseInt(page_numberString)
            }
        }catch (Exception e) {
            e.printStackTrace()
        }
        int offset = max * (page_number - 1)

        def complaints = Complaint.findAllBySubmitted_by(User.get(user_id), [offset: offset, max: max, sort: 'id', order: 'desc'])
        def complaint_count = Complaint.count

        int number_of_page = (complaint_count + max - 1) / max
        List<Integer> number_of_pages = new ArrayList<Integer>()
        for (int i = 1; i <= number_of_page; i++) {
            number_of_pages.add(i)
        }

        render(view: 'complaints', model: [complaints: complaints, number_of_pages: number_of_pages, page_number: page_number, max: max])
    }

    def complaints_list() {
        long user_id = (long) springSecurityService.currentUserId
        Role RoleData = UserRole.findByUser(User.get(user_id)).role
        int max = 20
        int page_number = 1
        try {
            if (params.page_number) {
                String page_numberString = params.page_number
                page_number = Integer.parseInt(page_numberString)
            }
        }catch (Exception e) {
            e.printStackTrace()
        }
        int offset = max * (page_number - 1)

        List<Complaint> complaints = new ArrayList<Complaint>()
        def complaint_count = 0

        if (RoleData.authority.equalsIgnoreCase("ROLE_ADMIN")) {
            complaints = Complaint.findAll([offset: offset, max: max, sort: 'id', order: 'desc'])
            complaint_count = Complaint.count
        }else {
            for (Escalate escalateData : Escalate.findAllByEscalated_to(User.get(user_id))) {
                complaints.add(escalateData.complaint)
            }
        }

        int number_of_page = (complaint_count + max - 1) / max
        List<Integer> number_of_pages = new ArrayList<Integer>()
        for (int i = 1; i <= number_of_page; i++) {
            number_of_pages.add(i)
        }

        render(view: 'complaints_list', model: [complaints: complaints, number_of_pages: number_of_pages, page_number: page_number, max: max])
    }

    def delete_complaint() {

    }

    @Transactional
    def edit_complaint(Complaint complaint) {
        complaint.save()
    }

    def escalate_complaint(long complaint_id) {
        long user_id = (long) springSecurityService.currentUserId
        UserDetails userInfo = UserDetails.findByUser(User.get(user_id))
        List<Complaint> complaints = new ArrayList<Complaint>()
        if (UserRole.findByUser(User.get(user_id)).role.authority.equalsIgnoreCase("ROLE_ADMIN")) {
            for (Complaint any_complaint : Complaint.findAll()) {
                complaints.add(any_complaint)
            }
        } else {
            for (Escalate escalateData : Escalate.findAllByEscalated_to(User.get(user_id))) {
                complaints.add(escalateData.complaint)
            }
        }
        List<UserDetails> escalatees = new ArrayList<UserDetails>()

        if (UserRole.findByUser(User.get(user_id)).role.authority.equalsIgnoreCase("ROLE_ADMIN")) {
            for (UserDetails any_user : UserDetails.findAll()) {
                escalatees.add(any_user)
            }
        } else if (Manage.findByUser(User.get(user_id)) == null) {
            for (Manage manageData : Manage.list()) {
                UserDetails manager_user_details = UserDetails.findByUser(manageData.user)
                escalatees.add(manager_user_details)
            }
        } else {
            for(UserDetails user_details : UserDetails.findAllByDepartment(userInfo.department)) {
                escalatees.add(user_details)
            }
        }

        if (params._action_escalate_complaint) {
            try {
                ManageController manageController = new ManageController()
                def calendar_time = Calendar.instance
                Escalate escalateData = new Escalate()
                JSONObject escalate_return = new JSONObject()

                if (params.complaint_id) {
                    String complaintString = params.complaint_id
                    escalateData.complaint = Complaint.get(complaint_id)
                    escalate_return.put("complaint_id", complaintString)
                }

                if (!(params.complaint_id && params.escalated_to)) {
                    render(view: 'escalate_complaint', model: [escalatees: escalatees, complaint_id: escalate_return.complaint_id, complaints: complaints, errorMessage: 'Please fill all fields!!'])
                    return
                }

                if (params.escalated_to) {
                    String escalated_to_id = params.escalated_to
                    escalateData.escalated_to = User.get(Long.parseLong(escalated_to_id))
                }

                String escalated_by_id = params.escalated_by_id
                escalateData.escalated_by = User.get(Long.parseLong(escalated_by_id))
                escalateData.escalated_time = new Timestamp(calendar_time.time.time)
                escalateData.is_accessed = false
                escalateData.is_processed = false
                Escalate results = escalateData.save(flash: true, failOnError: true)

                if (results) {
                    Complaint this_complaint = results.complaint
                    this_complaint.last_action = "Escalated to " + manageController.user_details(results.escalated_to.id).full_name
                    this.edit_complaint(this_complaint)
                    redirect controller: 'complaint', action: 'complaint_info', params: [complaint_id: results.complaint.id]
                }else {
                    render(view: 'escalate_complaint', model: [escalatees: escalatees, complaint_id: escalate_return.complaint_id, complaints: complaints, errorMessage: 'Failed to escalate!!'])
                    return
                }
            }catch (Exception e) {
                e.printStackTrace()
            }

        }else {
            render(view: 'escalate_complaint', model: [escalatees: escalatees, complaint_id: complaint_id, complaints: complaints])
        }
    }
}
