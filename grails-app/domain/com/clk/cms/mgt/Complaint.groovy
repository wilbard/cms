package com.clk.cms.mgt

import com.clk.cms.User

import java.sql.Timestamp

class Complaint {

    def calendar_time = Calendar.instance

    String title
    String description
    String last_action
    User submitted_by
    String status
    Timestamp created_time
    Timestamp updated_time = new Timestamp(calendar_time.time.time)

    static constraints = {
        title nullable: false, blank: false, unique: false
        description nullable: false, blank: false, unique: false
        last_action nullable: false, blank: false, unique: false
        created_time nullable: false, blank: false, unique: false
        submitted_by nullable: false, blank: false, unique: false
        status nullable: false, blank: false, unique: false
    }
}
