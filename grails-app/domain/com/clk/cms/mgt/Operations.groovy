package com.clk.cms.mgt

import com.clk.cms.User

import java.sql.Timestamp

class Operations {

    def calendar_time = Calendar.instance

    String event
    String description
    User operator
    Timestamp updated_time = new Timestamp(calendar_time.time.time)

    static constraints = {
        event nullable: false, blank: false, unique: false
        description nullable: false, blank: false, unique: false
        operator nullable: false, blank: false, unique: false
    }
}
