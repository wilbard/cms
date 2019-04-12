package com.clk.cms

import com.clk.cms.mgt.Department

class UserDetails {

    User user
    String full_name
    String email
    String phone_number
    String address
    String current_address
    Department department
    UserType user_type

    static constraints = {
        user nullable: false, blank: false, unique: false
        full_name nullable: false, blank: false, unique: false
        email nullable: true, blank: true, unique: false
        phone_number nullable: true, blank: true, unique: false
        address nullable: true, blank: true, unique: false
        current_address nullable: true, blank: true, unique: false
        department nullable: false, blank: false, unique: false
        user_type nullable: false, blank: false, unique: false
    }
}
