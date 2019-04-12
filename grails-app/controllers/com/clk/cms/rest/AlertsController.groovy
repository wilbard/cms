package com.clk.cms.rest

import com.clk.cms.User
import grails.gorm.transactions.Transactional
import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import org.apache.catalina.Manager
import org.grails.web.json.JSONObject
import org.springframework.web.bind.annotation.RequestBody

import java.sql.Timestamp

import static org.springframework.http.HttpStatus.*

@Secured(['ROLE_ADMIN', 'ROLE_MANAGER', 'ROLE_USER', 'ROLE_STAFF'])
class AlertsController {

    AlertsService alertsService
    def springSecurityService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    private User userInfo

    void myInfo() {
        long user_id = springSecurityService.currentUserId
        this.userInfo = User.get(user_id)
        this.institutionInfo = Manager.findByUser(this.userInfo).institution
    }

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond alertsService.list(params), model:[alertsCount: alertsService.count()]
    }

    def show(Long id) {
        respond alertsService.get(id)
    }

    def create() {
        respond new Alerts(params)
    }

    JSONObject inbox(@RequestBody User userData) {
        def alerts = Alerts.findAllByReceiverAndState(userData, 1, [max: 3, sort: "id", order: "desc"])
        int alerts_count = Alerts.countByReceiverAndState(userData, 1)
        JSONObject jsonData = new JSONObject()
        jsonData.put("alerts_count", alerts_count)
        jsonData.put("alerts", alerts)
        /**render(template: '/top_nav', model: [alerts: alerts, alerts_count: alerts_count])*/
        return jsonData
    }

    @Transactional
    def inbox_message(long alert_id) {
        def alert = Alerts.get(alert_id)
        Alerts alertDAta = Alerts.get(alert_id)
        try {
            alertDAta.state = 0
            alertDAta.status = "received"
            alertDAta.save()
        }catch (Exception e) {
            e.printStackTrace()
        }
        render(view: 'inbox_message', model: [alert: alert])
    }
    def sent_message(long alert_id) {
        def alert = Alerts.get(alert_id)
        render(view: 'sent_message', model: [alert: alert])
    }

    def inbox_messages() {
        this.myInfo()
        def alerts = Alerts.findAllByReceiver(this.userInfo, [sort: "id", order: "desc"])
        def sent_alerts = Alerts.findAllBySender(this.userInfo, [sort: "id", order: "desc"])

        render(view: 'inbox_messages', model: [alerts: alerts, sent_alerts: sent_alerts])
    }

    def compose_message() {
        this.myInfo()
        def current_user = this.userInfo
        def institution_info = this.institutionInfo
        def user_list = User.findAllByInstitution(this.institutionInfo)
        if (UserRole.findByUser(current_user).role.authority.equalsIgnoreCase("ROLE_ADMIN")) {
            user_list = User.list()
        }
        user_list.remove(this.userInfo)

        if (params._action_compose_message) {
            def calendar_time = Calendar.instance
            Alerts alertData = new Alerts()

            if (params.message) {
                String message = params.message
                alertData.message = message
            }
            if (params.receiver_id) {
                String receiverString = params.receiver_id
                Long receiver_id = Long.parseLong(receiverString)
                alertData.receiver = User.get(receiver_id)
            }

            if (!(params)) {
                render(view: 'compose_message', model: [current_user: current_user, institution_info: institution_info, user_list: user_list, alert_return: alertData, errorMessage: 'Fill both message and recipient!!'])
                return
            }

            alertData.institution = this.institutionInfo
            alertData.sender = this.userInfo
            alertData.sender_name = this.userInfo.first_name + " " + this.userInfo.last_name
            alertData.sent_time = new Timestamp(calendar_time.time.time)
            alertData.state = 1
            alertData.status = "sent"

            Alerts alert_results = alertData.save(flash: true, failOnError: true)

            if (alert_results) {
                render(view: 'compose_message', model: [current_user: current_user, institution_info: institution_info, user_list: user_list, successMessage: 'Message to ' + alert_results.receiver.first_name + ' ' + alert_results.receiver.last_name + ' has been delivered successfully'])
                return
            }else {
                render(view: 'compose_message', model: [current_user: current_user, institution_info: institution_info, user_list: user_list, alert_return: alertData, errorMessage: 'Failed to deliver the message'])
                return
            }

        }else {
            render(view: 'compose_message', model: [current_user: current_user, institution_info: institution_info, user_list: user_list])
        }
    }

    def save(Alerts alerts) {
        if (alerts == null) {
            notFound()
            return
        }

        try {
            alertsService.save(alerts)
        } catch (ValidationException e) {
            respond alerts.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'alerts.label', default: 'Alerts'), alerts.id])
                redirect alerts
            }
            '*' { respond alerts, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond alertsService.get(id)
    }

    def update(Alerts alerts) {
        if (alerts == null) {
            notFound()
            return
        }

        try {
            alertsService.save(alerts)
        } catch (ValidationException e) {
            respond alerts.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'alerts.label', default: 'Alerts'), alerts.id])
                redirect alerts
            }
            '*'{ respond alerts, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        alertsService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'alerts.label', default: 'Alerts'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'alerts.label', default: 'Alerts'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
