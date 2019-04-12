package com.clk.cms.mgt

import com.clk.cms.User

import java.sql.Timestamp

class Manage {

    def calendar_time = Calendar.instance

    User user
    Department department
    Timestamp updated_time = new Timestamp(calendar_time.time.time)

    static constraints = {
        user nullable: false, blank: false, unique: false
        department nullable: false, blank: false, unique: true
    }
}
