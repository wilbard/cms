package com.clk.cms

import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_ADMIN', 'ROLE_USER', 'ROLE_MANAGER', 'ROLE_STAFF'])
class HomeController {

    def index() {
        redirect controller:'home', action: 'homepage'
    }

    def homepage() {

    }
}
