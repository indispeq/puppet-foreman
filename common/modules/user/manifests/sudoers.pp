class user::sudoers {

	file { '/etc/sudoers':
		owner => root,
		group => root,
		mode => 0440,
		source => 'puppet:///modules/user/sudoers',
	}
}
