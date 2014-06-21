class ssh::service {
	include ssh::params

	service { $::ssh::params::ssh_service_name:
		ensure => running,
		hasstatus => true,
		hasrestart => true,
		enable => true,
		require => Class["ssh::config"],
	}
}
