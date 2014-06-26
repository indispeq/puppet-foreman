class nagios::contacts {
        include nagios::params

	nagios_contact { 'aszekely':
		email => 'aron.szekely@gmail.com',
		target => "/etc/$::nagios::params::nagios_service_name/conf.d/aszekely_contact.cfg",
		notify => [ Service[$::nagios::params::nagios_service_name], Exec['fix-permissions'] ],
		service_notification_commands => 'notify-service-by-email',
		host_notification_commands => 'notify-host-by-email',
		service_notification_period => '24x7',
	        host_notification_period =>	'24x7',
        	service_notification_options => 'w,u,c,r',
	        host_notification_options => 'd,r',
	}

	nagios_contactgroup { "sysadmins":
		members => "aszekely",
		target => "/etc/$::nagios::params::nagios_service_name/conf.d/sysadmins_contactgroup_definition.cfg",
		notify => [ Service[$::nagios::params::nagios_service_name], Exec['fix-permissions'] ],
	}

}

