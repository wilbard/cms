

// Added by the Spring Security Core plugin:
grails.plugin.springsecurity.userLookup.userDomainClassName = 'com.clk.cms.User'
grails.plugin.springsecurity.userLookup.authorityJoinClassName = 'com.clk.cms.UserRole'
grails.plugin.springsecurity.authority.className = 'com.clk.cms.Role'
grails.plugin.springsecurity.logout.postOnly = false
grails.databinding.dateFormats = ['dd/MM/yyyy HH:mm:ss', 'dd/MM/yyyy', 'yyyy-MM-dd', 'yyyy-MM-dd HH:mm:ss', 'yyyy-MM-dd HH:mm:ss.S', "yyyy-MM-dd'T'hh:mm:ss'Z'"]
grails.plugin.springsecurity.controllerAnnotations.staticRules = [
	[pattern: '/',               access: ['permitAll']],
	[pattern: '/error',          access: ['permitAll']],
	[pattern: '/index',          access: ['permitAll']],
	[pattern: '/index.gsp',      access: ['permitAll']],
	[pattern: '/shutdown',       access: ['permitAll']],
	[pattern: '/assets/**',      access: ['permitAll']],
	[pattern: '/**/js/**',       access: ['permitAll']],
	[pattern: '/**/css/**',      access: ['permitAll']],
	[pattern: '/**/images/**',   access: ['permitAll']],
	[pattern: '/**/favicon.ico', access: ['permitAll']],
    [pattern: '/api/complaint',	 access: ['permitAll']]
]

grails.plugin.springsecurity.filterChain.chainMap = [
	[pattern: '/assets/**',      filters: 'none'],
	[pattern: '/**/js/**',       filters: 'none'],
	[pattern: '/**/css/**',      filters: 'none'],
	[pattern: '/**/images/**',   filters: 'none'],
	[pattern: '/**/favicon.ico', filters: 'none'],
	[pattern: '/**',             filters: 'JOINED_FILTERS']
]

grails.plugin.springsecurity.successHandler.defaultTargetUrl = '/home/index'

grails {
    mail {
        host = "smtp.gmail.com"
        port = 25
        username = "chloruko@gmail.com"
        password = "Babakii1"
        props = ["mail.smtp.auth"              : "false",
                 "mail.smtp.socketFactory.port": "25",
                 "mail.smtp.starttls.enable"   : "true"]
    }
}
