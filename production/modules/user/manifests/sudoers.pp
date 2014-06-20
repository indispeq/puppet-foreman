class user::sudoers {

	package { 'sudo':
		ensure => installed,
	}

	augeas {'passwordless sudo':
		context => '/files/etc/sudoers',
		changes => [
			'set spec[user = "%sudo"]/user %sudo',
			'set spec[user = "%sudo"]/host_group/host ALL',
			'set spec[user = "%sudo"]/host_group/command ALL',
			'set spec[user = "%sudo"]/host_group/command/tag NOPASSWD',
			'set spec[user = "%sudo"]/host_group/command/runas_user ALL',
		]
	}

}
