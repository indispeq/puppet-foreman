class base-system {

	package { 'git':
		ensure => installed,
	}

	package { 'sysstat':
		ensure => installed,
	}

}
