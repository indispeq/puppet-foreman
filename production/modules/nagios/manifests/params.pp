class nagios::params {
	case $::operatingsystem {
		Ubuntu: {
			$nagios_package_name = 'nagios3'
			$nagios_service_name = 'nagios3'
		}
		default: {
			fail("Nagios params have not been written for this operatingsystem: ${::operatingsystem}")
		}
	}
}
