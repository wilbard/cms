package com.clk.cms.mgt

import grails.gorm.services.Service

@Service(Manage)
interface ManageService {

    Manage get(Serializable id)

    List<Manage> list(Map args)

    Long count()

    void delete(Serializable id)

    Manage save(Manage manage)

}