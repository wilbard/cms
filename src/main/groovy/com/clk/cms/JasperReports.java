package com.clk.cms;

import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.engine.export.ooxml.JRXlsxExporter;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;
import net.sf.jasperreports.export.SimpleXlsxReportConfiguration;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.util.HashMap;

public class JasperReports {

    public void excelReports(String ReportName, String name_id, String fileType, HashMap jasperParameter, String reports_folder){
        JasperConnection jConn = new JasperConnection();
        Connection connection = jConn.JasperConnections();
        this.deleteReport(ReportName+"_"+name_id, fileType, reports_folder);
        try{
            /**HashMap jasperParameter = new HashMap();*/
            JasperReport jasperReport = JasperCompileManager.compileReport(reports_folder+"/"+ReportName+".jrxml");
            JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport,jasperParameter, connection);
            ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
            OutputStream outputFile= new FileOutputStream(new File(reports_folder+"/"+ReportName+"_"+name_id+"." + fileType));

            JRXlsxExporter exporterXLS = new JRXlsxExporter();
            exporterXLS.setExporterInput(new SimpleExporterInput(jasperPrint));
            exporterXLS.setExporterOutput(new SimpleOutputStreamExporterOutput(outputFile));
            SimpleXlsxReportConfiguration exporterConfiguration = new SimpleXlsxReportConfiguration();
            exporterConfiguration.setDetectCellType(true);//Set configuration as you like it!!
            exporterConfiguration.setCollapseRowSpan(false);
            exporterXLS.setConfiguration(exporterConfiguration);
            exporterXLS.exportReport();
            outputFile.write(byteArrayOutputStream.toByteArray());
        }catch(Exception ex){
            ex.printStackTrace();
        }
    }

    public void pdfReports(String ReportName, String name_id, String fileType, HashMap jasperParameter, String reports_folder){
        JasperConnection jConn = new JasperConnection();
        Connection connection = jConn.JasperConnections();
        this.deleteReport(ReportName+"_"+name_id, fileType, reports_folder);
        try{
            JasperReport jasperReport;
            JasperPrint jasperPrint;
            /**HashMap jasperParameter = new HashMap();*/
            jasperReport = JasperCompileManager.compileReport(reports_folder+"/"+ReportName+".jrxml");
            jasperPrint = JasperFillManager.fillReport(jasperReport,jasperParameter, connection);
            OutputStream outputfile= new FileOutputStream(new File(reports_folder+"/"+ReportName+"_"+name_id+"." + fileType));

            JRPdfExporter exporter= new JRPdfExporter();
            SimpleOutputStreamExporterOutput c = new SimpleOutputStreamExporterOutput(outputfile);
            exporter.setExporterInput(new SimpleExporterInput(jasperPrint));
            exporter.setExporterOutput(c);
            exporter.exportReport();
        }catch(Exception ex){
            ex.printStackTrace();
        }
    }

    public boolean deleteReport(String ReportName, String fileType, String reports_folder){
        boolean resp = false;
        try{
            File file = new File(reports_folder+"/"+ReportName+"." + fileType);
            if(file.delete()){
                resp = true;
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return resp;
    }

    public String reportDirectory(){
        return "/home/shirima/adalipa/JasperReports";
    }

    public String jasperDirectory(){
        return "/home/shirima/adalipa/JasperReports";
    }
}
