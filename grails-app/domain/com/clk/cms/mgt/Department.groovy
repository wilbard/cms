package com.clk.cms.mgt

class Department {

    String department_name

    static constraints = {
        department_name nullable: false, blank: false, unique: false
    }
}
