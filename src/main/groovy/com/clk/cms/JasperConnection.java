package com.clk.cms;

import java.sql.Connection;
import java.sql.DriverManager;

public class JasperConnection {
    public Connection JasperConnections(){
        Connection conn = null;
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            String str = "jdbc:mysql://127.0.0.1:3306/unhcrcms?verifyServerCertificate=false&useSSL=false&requireSSL=false";
            conn = DriverManager.getConnection(str, "cmsroot", "unhcr@123");
        }
        catch (Exception localException)
        {
            localException.printStackTrace();
        }
        return conn;
    }
}
