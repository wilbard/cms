package com.clk.cms

import grails.plugin.springsecurity.annotation.Secured

import java.sql.Timestamp
import java.text.SimpleDateFormat

@Secured(['ROLE_ADMIN', 'ROLE_MANAGER', 'ROLE_STAFF'])
class ReportsController {

    def springSecurityService

    def index() { }

    def cms_reports() {
        long user_id = (long) springSecurityService.currentUserId
        String reports_folder = "/home/shirima/cms/JasperReports"
        if (params._action_cms_reports) {
            if (!(params.from_date && params.to_date)) {
                render(view: 'cms_reports', model: [errorMessage: 'Date fields should not be empty!!'])
            }

            try {
                SimpleDateFormat smdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
                String reportName = params.reportName
                String fileType = params.fileType
                String fromDateString = params.from_date
                Date simpleFromDate = smdf.parse(fromDateString + " 00:00:00")
                Timestamp from_date = new Timestamp(simpleFromDate.getTime())
                String toDateString = params.to_date
                Date simpleToDate = smdf.parse(toDateString + " 23:59:59")
                Timestamp to_date = new Timestamp(simpleToDate.getTime())
                String file_format = "pdf"

                HashMap report_params = new HashMap()
                report_params.put("from_date", from_date)
                report_params.put("to_date", to_date)

                JasperReports jasperReports = new JasperReports()
                if (fileType.equalsIgnoreCase("excel")) {
                    file_format = "xlsx"
                    jasperReports.excelReports(reportName, user_id.toString(), file_format, report_params, reports_folder)
                } else if (fileType.equalsIgnoreCase("pdf")) {
                    jasperReports.pdfReports(reportName, user_id.toString(), file_format, report_params, reports_folder)
                }

                def resourceFiles = this.class.getClassLoader().getResourceAsStream("reports" + reportName + "_" + user_id.toString() + "." + file_format)
                def file = new File("${reports_folder}/${reportName + "_" + user_id.toString()}.${file_format}")
                if (file.exists()) {
                    if (fileType.equalsIgnoreCase("xlsx")) {
                        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
                        response.setHeader("Content-Disposition", "attachment; filename=${reportName + "_" + user_id.toString()}.${file_format}")
                        response.outputStream << file.bytes
                        return
                    } else if (fileType.equalsIgnoreCase("pdf")) {
                        response.setContentType("application/pdf")
                        response.setHeader("Content-disposition", "filename=${reportName + "_" + user_id.toString()}.${file_format}")
                        response.outputStream << file.newInputStream()
                        return
                    }
                } else {
                    render(view: 'cms_reports', model: [errorMessage: 'Invalid request for complaints report'])
                }
            }catch (Exception e) {
                e.printStackTrace()
            }
        }
    }
}
