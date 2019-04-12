package com.clk.cms.rest

import com.clk.cms.User

import java.sql.Timestamp

class Alerts {

    def calendar_time = Calendar.instance

    User sender
    String sender_name
    User receiver
    String message
    Timestamp sent_time
    Timestamp updated_time = new Timestamp(calendar_time.time.time)
    int state
    String status

    static constraints = {
        institution nullable: false, blank: false, unique: false
        sender nullable: false, blank: false, unique: false
        sender_name nullable: false, blank: false, unique: false
        receiver nullable: false, blank: false, unique: false
        message nullable: false, blank: false, unique: false
        sent_time nullable: false, blank: false, unique: false
        state nullable: false, blank: false, unique: false
        status nullable: false, blank: false, unique: false
    }

    static mapping = {
        message sqlType: 'longText'
    }
}

