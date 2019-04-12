package com.clk.cms

import com.clk.cms.mgt.Complaint
import com.clk.cms.mgt.Department
import com.clk.cms.mgt.Escalate
import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import org.grails.web.json.JSONObject

import java.sql.Timestamp
import java.text.SimpleDateFormat

import static org.springframework.http.HttpStatus.*

@Secured(['ROLE_ADMIN', 'ROLE_MANAGER', 'ROLE_STAFF'])
class ChartController {

    ChartService chartService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond chartService.list(params), model:[chartCount: chartService.count()]
    }

    def show(Long id) {
        respond chartService.get(id)
    }

    def create() {
        respond new Chart(params)
    }

    def save(Chart chart) {
        if (chart == null) {
            notFound()
            return
        }

        try {
            chartService.save(chart)
        } catch (ValidationException e) {
            respond chart.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'chart.label', default: 'Chart'), chart.id])
                redirect chart
            }
            '*' { respond chart, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond chartService.get(id)
    }

    def update(Chart chart) {
        if (chart == null) {
            notFound()
            return
        }

        try {
            chartService.save(chart)
        } catch (ValidationException e) {
            respond chart.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'chart.label', default: 'Chart'), chart.id])
                redirect chart
            }
            '*'{ respond chart, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        chartService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'chart.label', default: 'Chart'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'chart.label', default: 'Chart'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    def our_charts() {

    }

    def processed_complaints() {
        JSONObject jsonData = new JSONObject()
        JSONObject jsonData2 = new JSONObject()

        for (Escalate escalateData : Escalate.findAll()) {
            Department departmentData = UserDetails.findByUser(escalateData.escalated_to).department

            if (jsonData.containsKey(departmentData.department_name)) {
                jsonData.put(departmentData.department_name, jsonData.getInt(departmentData.department_name) + 1)
            }else {
                jsonData.put(departmentData.department_name, 1)
            }
        }

        def escalateQuery = Escalate.executeQuery("select u.id from Escalate e join e.complaint c join e.escalated_to u where c.status = ?", ["PROCESSED"])

        escalateQuery.each { item ->
            String userId = item
            Department department = UserDetails.findByUser(User.get(Long.parseLong(userId))).department

            if (jsonData2.containsKey(department.department_name)) {
                jsonData2.put(department.department_name, jsonData2.getInt(department.department_name) + 1)
            }else {
                jsonData2.put(department.department_name, 1)
            }
        }

        JSONObject fee_info = new JSONObject()
        fee_info.put("desired", jsonData)
        fee_info.put("current", jsonData2)
        render fee_info as JSON
    }

    def annual_chart() {
        JSONObject monthly = new JSONObject()
        SimpleDateFormat now_sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
        def n = Calendar.instance
        def c = Calendar.instance
        def c1 = Calendar.instance
        def c2 = Calendar.instance
        def c3 = Calendar.instance
        def c4 = Calendar.instance
        def c5 = Calendar.instance
        def c6 = Calendar.instance
        String this_months = n.get(Calendar.YEAR) + "-" + String.format("%02d", n.get(Calendar.MONTH))
        try {
            c.add(Calendar.MONTH, -6)
            String last_months = c.get(Calendar.YEAR) + "-" + String.format("%02d", c.get(Calendar.MONTH)) + "-01 00:00:00"
            c6.add(Calendar.MONTH, -6)
            String last_six_months = c6.get(Calendar.YEAR) + "-" + String.format("%02d", c6.get(Calendar.MONTH))
            c5.add(Calendar.MONTH, -5)
            String last_five_months = c5.get(Calendar.YEAR) + "-" + String.format("%02d", c5.get(Calendar.MONTH))
            c4.add(Calendar.MONTH, -4)
            String last_four_months = c4.get(Calendar.YEAR) + "-" + String.format("%02d", c4.get(Calendar.MONTH))
            c3.add(Calendar.MONTH, -3)
            String last_three_months = c3.get(Calendar.YEAR) + "-" + String.format("%02d", c3.get(Calendar.MONTH))
            c2.add(Calendar.MONTH, -2)
            String last_two_months = c2.get(Calendar.YEAR) + "-" + String.format("%02d", c2.get(Calendar.MONTH))
            c1.add(Calendar.MONTH, -1)
            String last_one_months = c1.get(Calendar.YEAR) + "-" + String.format("%02d", c1.get(Calendar.MONTH))

            monthly.put(last_six_months, 0)
            monthly.put(last_five_months, 0)
            monthly.put(last_four_months, 0)
            monthly.put(last_three_months, 0)
            monthly.put(last_two_months, 0)
            monthly.put(last_one_months, 0)
            monthly.put(this_months, 0)

            Date this_time = now_sdf.parse(last_months)
            Timestamp calendar_time = new Timestamp(this_time.getTime())
            def annual_complaint = Complaint.executeQuery("select DATE_FORMAT(p.created_time, '%Y-%m'), count(p.id) from Complaint as p " +
                    "where p.created_time >= ? group by DATE_FORMAT(created_time, '%Y-%m') order by DATE_FORMAT(created_time, '%Y-%m') asc", [calendar_time])

            annual_complaint.each { item ->
                String month = item[0]
                String count = item[1]
                monthly.put(month, count)
            }

        }catch (Exception e) {
            e.printStackTrace()
        }
        render monthly as JSON
    }

    def departmental_complaints() {
        JSONObject departments = new JSONObject()
        def c = Calendar.instance
        SimpleDateFormat now_sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")

        try {
            c.add(Calendar.MONTH, -1)
            String last_months = c.get(Calendar.YEAR) + "-" + String.format("%02d", c.get(Calendar.MONTH)) + "-01 00:00:00"

            Date this_time = now_sdf.parse(last_months)
            Timestamp calendar_time = new Timestamp(this_time.getTime())
            def departmental = Escalate.executeQuery("select u.id from Escalate e join e.escalated_to u where e.escalated_time > ?", [calendar_time])

            int count_complaint = 0
            departmental.each { item ->
                String user_id = item
                UserDetails userDetails = UserDetails.findByUser(User.get(Long.parseLong(user_id)))

                if (departments.containsKey(userDetails.department.department_name)) {
                    departments.put(userDetails.department.department_name, departments.getInt(userDetails.department.department_name) + 1)
                }else {
                    departments.put(userDetails.department.department_name, 1)
                }
                count_complaint = count_complaint + 1
            }

            Iterator keys = departments.keys()
            while (keys.hasNext()) {
                Object key = keys.next()
                int value = departments.getInt((String) key)
                int new_value = (value/count_complaint) * 360
                departments.put(key, new_value)
                /**System.out.println("Key: " + key + " -> Value: " + new_value)*/
            }

        }catch (Exception e) {
            e.printStackTrace()
        }

        render departments as JSON
    }

    def pie_chart_complaints() {

    }

    def complaints_attainment() {

    }

    def semi_annual_complaints() {

    }
}
