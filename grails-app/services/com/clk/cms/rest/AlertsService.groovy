package com.clk.cms.rest

import grails.gorm.services.Service

@Service(Alerts)
interface AlertsService {

    Alerts get(Serializable id)

    List<Alerts> list(Map args)

    Long count()

    void delete(Serializable id)

    Alerts save(Alerts alerts)

}