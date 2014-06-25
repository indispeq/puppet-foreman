class nagios::export {
	include nagios::params

	$monitor_ips = '192.168.228.104'

	file { '/etc/nagios/nrpe_local.cfg':
		notify => Service['nagios-nrpe-server'],
		content => template('nagios/nrpe_local.cfg.erb'),
		owner => nagios,
		group => nagios,
	}
	file { '/etc/nagios/nrpe.cfg':
		notify => Service['nagios-nrpe-server'],
		source => 'puppet:///modules/nagios/nrpe.cfg',
		owner => nagios,
		group => nagios,
	}

	@@nagios_host { $::hostname :
        	ensure              => present,
	        address             => $::ipaddress,
	        use                 => 'generic-host',
        	check_command       => 'check-host-alive',
        	target              => "/etc/$::nagios::params::nagios_service_name/conf.d/${::hostname}.cfg",
	}
 
	@@nagios_service { "${::hostname}_check-load":
        	ensure              => present,
	        use                 => 'generic-service',
        	host_name           => $::hostname,
	        service_description => 'Current Load',
        	check_command       => 'check_nrpe_1arg!check_load',
	        target              => "/etc/$::nagios::params::nagios_service_name/conf.d/${::hostname}.cfg",
	}

	@@nagios_service { "${::hostname}_check-zombie-procs":
        	ensure              => present,
	        use                 => 'generic-service',
        	host_name           => $::hostname,
	        service_description => 'Zombie Processes',
        	check_command       => 'check_nrpe_1arg!check_zombie_procs',
	        target              => "/etc/$::nagios::params::nagios_service_name/conf.d/${::hostname}.cfg",
	}
 
	@@nagios_service { "${::hostname}_check-disk":
        	ensure              => present,
	        use                 => 'generic-service',
        	host_name           => $::hostname,
	        service_description => 'hda1 disk usage',
        	check_command       => 'check_nrpe_1arg!check_hda1',
	        target              => "/etc/$::nagios::params::nagios_service_name/conf.d/${::hostname}.cfg",
	}


}
