package com.clk.cms.mgt

import com.clk.cms.Role
import com.clk.cms.User
import com.clk.cms.UserDetails
import com.clk.cms.UserRole
import com.clk.cms.UserType
import grails.gorm.transactions.Transactional
import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import org.grails.web.json.JSONObject

import static org.springframework.http.HttpStatus.*

@Secured(['ROLE_ADMIN', 'ROLE_MANAGER'])
class ManageController {

    ManageService manageService
    def springSecurityService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond manageService.list(params), model:[manageCount: manageService.count()]
    }

    UserDetails user_details(long user_id) {
        return UserDetails.findByUser(User.get(user_id))
    }

    Escalate escalate_details(long complaint_id, long user_id) {
        return Escalate.findByComplaintAndEscalated_to(Complaint.get(complaint_id), User.get(user_id))
    }

    Escalate escalator_details(long complaint_id, long user_id) {
        return Escalate.findByComplaintAndEscalated_by(Complaint.get(complaint_id), User.get(user_id))
    }

    def show(Long id) {
        respond manageService.get(id)
    }

    def create() {
        respond new Manage(params)
    }

    def save(Manage manage) {
        if (manage == null) {
            notFound()
            return
        }

        try {
            manageService.save(manage)
        } catch (ValidationException e) {
            respond manage.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'manage.label', default: 'Manage'), manage.id])
                redirect manage
            }
            '*' { respond manage, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond manageService.get(id)
    }

    def update(Manage manage) {
        if (manage == null) {
            notFound()
            return
        }

        try {
            manageService.save(manage)
        } catch (ValidationException e) {
            respond manage.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'manage.label', default: 'Manage'), manage.id])
                redirect manage
            }
            '*'{ respond manage, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        manageService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'manage.label', default: 'Manage'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'manage.label', default: 'Manage'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    def add_department() {
        if (params._action_add_department) {
            try {
                Department departmentData = new Department()
                JSONObject department_return = new JSONObject()

                if (params.department_name) {
                    String department_name = params.department_name
                    departmentData.department_name = department_name
                    department_return.put("department_name", department_name)
                }

                if (!(params.department_name)) {
                    render(view: 'add_department', model: [department_return: department_return, errorMessage: 'Department Name must be filed'])
                    return
                }

                Department results = departmentData.save(flash: true, failOnError: true)
                if (results) {
                    redirect controller: 'manage', action: 'department_info', params: [id: results.id]
                } else {
                    render(view: 'add_department', model: [department_return: department_return, errorMessage: 'Failed to add Department!!'])
                }

            }catch (Exception e) {
                e.printStackTrace()
            }

        }else {
            render(view: 'add_department')
        }
    }

    def department_info(long id) {
        def departments = Department.get(id)

        render(view: 'department_info', model: [departments: departments])
    }

    def departments() {
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

        def departments = Department.findAll([offset: offset, max: max, sort: 'id', order: 'asc'])
        def dep_count = Department.count

        int number_of_page = (dep_count + max - 1) / max
        List<Integer> number_of_pages = new ArrayList<Integer>()
        for (int i = 1; i <= number_of_page; i++) {
            number_of_pages.add(i)
        }

        render(view: 'departments', model: [departments: departments, number_of_pages: number_of_pages, page_number: page_number, max: max])
    }

    @Transactional
    def update_department(long department_id) {
        def department_info = Department.get(department_id)
        if (params._action_update_department) {
            try {
                if (params.department_name) {
                    String department_name = params.department_name
                    department_info.department_name = department_name
                }

                if (!(params.department_name)) {
                    render(view: 'update_department', model: [department_info: department_info, errorMessage: 'Department Name must be filed'])
                    return
                }

                Department results = department_info.save(flash: true, failOnError: true)

                if (results) {
                    redirect controller: 'manage', action: 'department_info', params: [id: results.id]
                } else {
                    render(view: 'update_department', model: [department_info: department_info, errorMessage: 'Failed to update Department!!'])
                }

            }catch (Exception e) {
                e.printStackTrace()
            }

        }else {
            render(view: 'update_department', model: [department_info: department_info])
        }
    }

    def delete_department() {

    }

    def user_info(long userId) {
        def user_list = UserDetails.get(userId)
        render(view: 'user_info', model: [user_list: user_list])
    }

    def complete_user_info() {
        def departments = Department.list()
        def user_types = UserType.list()
        String username = params.username

        if (params._action_complete_user_info) {
            try {
                UserDetails userDetailsData = new UserDetails()
                JSONObject user_return = new JSONObject()

                if (params.full_name) {
                    String full_name = params.full_name
                    userDetailsData.full_name = full_name
                    user_return.put("full_name", full_name)
                }

                if (params.department_id) {
                    String department_id = params.department_id
                    userDetailsData.department = Department.get(Long.parseLong(department_id))
                    user_return.put("department_id", department_id)
                }

                if (params.user_type_id) {
                    String user_type_id = params.user_type_id
                    userDetailsData.user_type = UserType.get(Long.parseLong(user_type_id))
                    user_return.put("user_type_id", user_type_id)
                }

                if (!(params.full_name && params.username && params.department_id && params.user_type_id)) {
                    render(view: 'complete_user_info', model: [user_types: user_types, departments: departments, user_return: user_return, errorMessage: 'All fields must be filed'])
                    return
                }

                UserDetails results = userDetailsData.save(flash: true, failOnError: true)
                if (results) {
                    redirect controller: 'manage', action: 'user_info', params: [userId: results.id]
                } else {
                    render(view: 'complete_user_info', model: [username: username, user_types: user_types, departments: departments, user_return: user_return, errorMessage: 'Please complete user details!!'])
                }

            }catch (Exception e) {
                e.printStackTrace()
            }

        }else {
            render(view: 'complete_user_info', model: [user_types: user_types, departments: departments, username: username])
        }

    }

    def add_user() {
        def departments = Department.list()
        def user_types = UserType.list()

        if (params._action_add_user) {
            try {
                User userData = new User()
                UserRole userRoleData = new UserRole()
                UserDetails userDetailsData = new UserDetails()
                JSONObject user_return = new JSONObject()

                if (params.full_name) {
                    String full_name = params.full_name
                    userDetailsData.full_name = full_name
                    user_return.put("full_name", full_name)
                }

                if (params.username) {
                    String username = params.username
                    userData.username = username
                    user_return.put("username", username)
                }

                if (params.department_id) {
                    String department_id = params.department_id
                    userDetailsData.department = Department.get(Long.parseLong(department_id))
                    user_return.put("department_id", department_id)
                }

                if (params.password) {
                    String password = params.password
                    userData.password = password
                }

                if (params.user_type_id) {
                    String user_type_id = params.user_type_id
                    userDetailsData.user_type = UserType.get(Long.parseLong(user_type_id))
                    user_return.put("user_type_id", user_type_id)
                }

                if (params.address) {
                    String address = params.address
                    userDetailsData.address = address
                    user_return.put("address", address)
                }

                if (params.current_address) {
                    String current_address = params.current_address
                    userDetailsData.current_address = current_address
                    user_return.put("current_address", current_address)
                }

                if (params.email) {
                    String email = params.email
                    userDetailsData.email = email
                    user_return.put("email", email)
                }

                if (params.phone_number) {
                    String phone_number = params.phone_number
                    userDetailsData.phone_number = phone_number
                    user_return.put("phone_number", phone_number)
                }

                if (!(params.full_name && params.username && params.department_id && params.password && params.confirm && params.user_type_id)) {
                    render(view: 'add_user', model: [user_types: user_types, departments: departments, user_return: user_return, errorMessage: 'Fields marked \'*\' must be filed'])
                    return
                }

                String username = params.username
                if (User.findByUsername(username) != null) {
                    render(view: 'add_user', model: [user_types: user_types, departments: departments, user_return: user_return, errorMessage: 'Someone is already registered using this username!!'])
                    return
                }

                String password1 = params.password
                String password2 = params.confirm
                if (!password1.equalsIgnoreCase(password2)) {
                    render(view: 'add_user', model: [user_types: user_types, departments: departments, user_return: user_return, errorMessage: 'Password does not match'])
                    return
                }

                userRoleData.role = Role.findByAuthority("ROLE_STAFF")

                User user_results = userData.save(flash: true, failOnError: true)

                if (user_results) {
                    userRoleData.user = user_results
                    userRoleData.save()
                    userDetailsData.user = user_results
                    UserDetails results = userDetailsData.save(flash: true, failOnError: true)
                    if (results) {
                        redirect controller: 'manage', action: 'user_info', params: [userId: results.id]
                    } else {
                        render(view: 'complete_user_info', model: [username: user_results.username, user_types: user_types, departments: departments, user_return: user_return, errorMessage: 'Please complete user details!!'])
                    }
                }else {
                    render(view: 'add_user', model: [user_types: user_types, departments: departments, user_return: user_return, errorMessage: 'Failed to add user!!'])
                    return
                }

            }catch (Exception e) {
                e.printStackTrace()
            }

        }else {
            render(view: 'add_user', model: [user_types: user_types, departments: departments])
        }
    }

    def user_list() {
        int max = 5
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

        def user_list = UserDetails.findAll([offset: offset, max: max, sort: 'id', order: 'asc'])
        def user_count = UserDetails.count

        int number_of_page = (user_count + max - 1) / max
        List<Integer> number_of_pages = new ArrayList<Integer>()
        for (int i = 1; i <= number_of_page; i++) {
            number_of_pages.add(i)
        }

        render(view: 'user_list', model: [user_list: user_list, number_of_pages: number_of_pages, page_number: page_number, max: max])
    }

    def update_user() {

    }

    def user_activation() {

    }

    def user_delete() {

    }

    def add_role() {

    }

    def roles() {

    }

    def update_role() {

    }

    def user_roles() {

    }

    def update_user_role() {

    }

    @Transactional
    def edit_user_role(UserRole userRole) {
        userRole.role = Role.findByAuthority("ROLE_MANAGER")
        userRole.save()
    }

    def add_manager() {
        def departments = Department.list()
        def user_details = UserDetails.list()

        if (params._action_add_manager) {
            try {
                Manage manageData = new Manage()

                if (!(params.user_id && params.department_id)) {
                    render(view: 'add_manager', model: [user_details: user_details, departments: departments, errorMessage: 'Please fill all fields!!'])
                    return
                }

                String user_id = params.user_id
                UserDetails userDetailsData = UserDetails.get(Long.parseLong(user_id))
                manageData.user = userDetailsData.user
                String department_id = params.department_id

                UserRole userRoleData = UserRole.findByUser(userDetailsData.user)

                manageData.department = Department.get(Long.parseLong(department_id))

                Manage results = manageData.save(flash: true, failOnError: true)

                if (results) {
                    this.edit_user_role(userRoleData)
                    redirect controller: 'manage', action: 'manage_info', params: [manage_id: results.id]
                }else {
                    render(view: 'add_manager', model: [user_details: user_details, departments: departments, errorMessage: 'Failed to add Supervisor!!'])
                    return
                }

            }catch (Exception e) {
                e.printStackTrace()
            }
        }else {
            render(view: 'add_manager', model: [user_details: user_details, departments: departments])
        }
    }

    def managers() {
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

        def managers = Manage.findAll([offset: offset, max: max, sort: 'id', order: 'asc'])
        def manager_count = Manage.count

        int number_of_page = (manager_count + max - 1) / max
        List<Integer> number_of_pages = new ArrayList<Integer>()
        for (int i = 1; i <= number_of_page; i++) {
            number_of_pages.add(i)
        }
        render(view: 'managers', model: [managers: managers, number_of_pages: number_of_pages, page_number: page_number, max: max])
    }

    def manage_info(long manage_id) {
        def managers = Manage.get(manage_id)
        render(view: 'manage_info', model: [managers: managers])
    }

    def update_manager() {

    }

    def delete_manager() {

    }

    UserDetails getUserDetails(long user_id) {
        User userData = User.get(user_id)
        return UserDetails.findByUser(userData)
    }
}
