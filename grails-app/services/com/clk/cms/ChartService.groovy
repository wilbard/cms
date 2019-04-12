package com.clk.cms

import grails.gorm.services.Service

@Service(Chart)
interface ChartService {

    Chart get(Serializable id)

    List<Chart> list(Map args)

    Long count()

    void delete(Serializable id)

    Chart save(Chart chart)

}