package com.clk.cms.mgt

import grails.testing.web.interceptor.InterceptorUnitTest
import spock.lang.Specification

class OperationsInterceptorSpec extends Specification implements InterceptorUnitTest<OperationsInterceptor> {

    def setup() {
    }

    def cleanup() {

    }

    void "Test operations interceptor matching"() {
        when:"A request matches the interceptor"
            withRequest(controller:"operations")

        then:"The interceptor does match"
            interceptor.doesMatch()
    }
}
