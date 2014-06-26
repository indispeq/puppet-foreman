class nagios::export {
	include nagios::params

	@@nagios_host { $::hostname :
        	ensure              => present,
	        address             => $::ipaddress,
	        use                 => 'generic-host',
        	check_command       => 'check-host-alive',
		contact_groups	=> 'sysadmins',
        	target              => "/etc/$::nagios::params::nagios_service_name/conf.d/${::hostname}.cfg",
	}
 
	@@nagios_service { "${::hostname}_check-load":
        	ensure              => present,
	        use                 => 'generic-service',
        	host_name           => $::hostname,
	        service_description => 'Current Load',
        	check_command       => 'check_nrpe_1arg!check_load',
		contact_groups	=> 'sysadmins',
	        target              => "/etc/$::nagios::params::nagios_service_name/conf.d/${::hostname}.cfg",
	}

	@@nagios_service { "${::hostname}_check-zombie-procs":
        	ensure              => present,
	        use                 => 'generic-service',
        	host_name           => $::hostname,
	        service_description => 'Zombie Processes',
        	check_command       => 'check_nrpe_1arg!check_zombie_procs',
		contact_groups	=> 'sysadmins',
	        target              => "/etc/$::nagios::params::nagios_service_name/conf.d/${::hostname}.cfg",
	}
 
	@@nagios_service { "${::hostname}_check-disk":
        	ensure              => present,
	        use                 => 'generic-service',
        	host_name           => $::hostname,
	        service_description => 'hda1 disk usage',
        	check_command       => 'check_nrpe_1arg!check_hda1',
		contact_groups	=> 'sysadmins',
	        target              => "/etc/$::nagios::params::nagios_service_name/conf.d/${::hostname}.cfg",
	}

        @@nagios_service { "${::hostname}_check-ssh":
                ensure              => present,
                use                 => 'generic-service',
                host_name           => $::hostname,
                service_description => 'ssh_service',
                check_command       => 'check_ssh',
		contact_groups	=> 'sysadmins',
                target              => "/etc/$::nagios::params::nagios_service_name/conf.d/${::hostname}.cfg",
        }


}
