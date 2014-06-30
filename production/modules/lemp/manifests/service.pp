class lemp::service::nginx {

	service { 'nginx':
		ensure => running,
		enable => true,
		hasstatus => true,
		hasrestart => true,
		require => Class['lemp::config::nginx'],
	}

}
