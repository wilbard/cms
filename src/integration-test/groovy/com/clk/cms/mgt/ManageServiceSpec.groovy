package com.clk.cms.mgt

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class ManageServiceSpec extends Specification {

    ManageService manageService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new Manage(...).save(flush: true, failOnError: true)
        //new Manage(...).save(flush: true, failOnError: true)
        //Manage manage = new Manage(...).save(flush: true, failOnError: true)
        //new Manage(...).save(flush: true, failOnError: true)
        //new Manage(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //manage.id
    }

    void "test get"() {
        setupData()

        expect:
        manageService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<Manage> manageList = manageService.list(max: 2, offset: 2)

        then:
        manageList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        manageService.count() == 5
    }

    void "test delete"() {
        Long manageId = setupData()

        expect:
        manageService.count() == 5

        when:
        manageService.delete(manageId)
        sessionFactory.currentSession.flush()

        then:
        manageService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        Manage manage = new Manage()
        manageService.save(manage)

        then:
        manage.id != null
    }
}
