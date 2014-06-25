class nagios::monitor {
	include nagios::params

	package { [ $::nagios::params::nagios_package_name, 'nagios-nrpe-plugin' ]:
		ensure => installed,
	}->

	exec { 'fix-permissions':
        	command     => "/usr/bin/find /etc/$::nagios::params::nagios_service_name/conf.d -type f -name '*cfg' | xargs chmod +r",
	        refreshonly => true,
	}->

	service { $::nagios::params::nagios_service_name:
		ensure => running,
		hasstatus => true,
		enable => true,
		subscribe => Package[$::nagios::params::nagios_package_name],
	}

        file { "/etc/$::nagios::params::nagios_service_name/htpasswd.users":
                source => 'puppet:///modules/nagios/htpasswd.users',
        }

	Nagios_host	<<| |>>	{ notify => [ Service[$::nagios::params::nagios_service_name], Exec['fix-permissions'] ] }
	Nagios_hostgroup	<<| |>>	{ notify => [ Service[$::nagios::params::nagios_service_name], Exec['fix-permissions'] ] }
	Nagios_service	<<| |>>	{ notify => [ Service[$::nagios::params::nagios_service_name], Exec['fix-permissions'] ] }

}

