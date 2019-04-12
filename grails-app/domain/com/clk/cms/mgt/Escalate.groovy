package com.clk.cms.mgt

import com.clk.cms.User

import java.sql.Timestamp

class Escalate {

    def calendar_time = Calendar.instance

    Complaint complaint
    User escalated_to
    User escalated_by
    Timestamp escalated_time
    boolean is_accessed = false
    boolean is_processed = false
    Timestamp updated_time = new Timestamp(calendar_time.time.time)

    static constraints = {
        complaint nullable: false, blank: false, unique: false
        escalated_to nullable: false, blank: false, unique: false
        escalated_by nullable: false, blank: false, unique: false
        escalated_time nullable: false, blank: false, unique: false
        is_accessed nullable: false, blank: false, unique: false
        is_processed nullable: false, blank: false, unique: false
    }
}
