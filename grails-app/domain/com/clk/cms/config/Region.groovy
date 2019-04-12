package com.clk.cms.config

class Region {

    String region_name
    String state

    static hasMany = [districts: District]

    static constraints = {
        state blank: true, nullable: true
    }

    String toString() {
        return region_name
    }
}
