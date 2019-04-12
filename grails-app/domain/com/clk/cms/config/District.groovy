package com.clk.cms.config

class District {

    Region region
    String district_name

    static belongsTo = Region

    static constraints = {
    }

    String toString() {
        return district_name
    }
}
