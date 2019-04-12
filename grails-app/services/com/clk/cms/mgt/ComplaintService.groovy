package com.clk.cms.mgt

import grails.gorm.services.Service

@Service(Complaint)
interface ComplaintService {

    Complaint get(Serializable id)

    List<Complaint> list(Map args)

    Long count()

    void delete(Serializable id)

    Complaint save(Complaint complaint)

}