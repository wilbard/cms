package com.clk.cms

class UserType {

    String user_type
    String description

    static constraints = {
        user_type nullable: false, blank: false, unique: false
        description nullable: true, blank: true, unique: false
    }
}
