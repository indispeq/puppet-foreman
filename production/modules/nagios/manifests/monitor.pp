#need to configure nagiosadmin user htpasswd file, etc...

class nagios::monitor {
	include nagios::params

	package { [ $::nagios::params::nagios_package_name, 'nagios-plugins' ]:
		ensure => installed,
	}

	service { $::nagios::params::nagios_service_name:
		ensure => running,
		hasstatus => true,
		enable => true,
		subscribe => [ Package[$::nagios::params::nagios_package_name], Package['nagios-plugins'] ],
	}

	Nagios_host	<<| |>>	{ notify => Service[$::nagios::params::nagios_service_name] }
	Nagios_service	<<| |>>	{ notify => Service[$::nagios::params::nagios_service_name] }

}
