package com.clk.cms

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class ChartServiceSpec extends Specification {

    ChartService chartService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new Chart(...).save(flush: true, failOnError: true)
        //new Chart(...).save(flush: true, failOnError: true)
        //Chart chart = new Chart(...).save(flush: true, failOnError: true)
        //new Chart(...).save(flush: true, failOnError: true)
        //new Chart(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //chart.id
    }

    void "test get"() {
        setupData()

        expect:
        chartService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<Chart> chartList = chartService.list(max: 2, offset: 2)

        then:
        chartList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        chartService.count() == 5
    }

    void "test delete"() {
        Long chartId = setupData()

        expect:
        chartService.count() == 5

        when:
        chartService.delete(chartId)
        sessionFactory.currentSession.flush()

        then:
        chartService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        Chart chart = new Chart()
        chartService.save(chart)

        then:
        chart.id != null
    }
}
