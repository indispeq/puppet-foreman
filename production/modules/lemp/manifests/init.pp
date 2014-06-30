class lemp {
	class { '::lemp::install::nginx': } ->
	class { '::lemp::config::nginx':
		worker_processes => '5',
                keepalive_timeout => '45',
	 } ->
	class { '::lemp::service::nginx': } ->

	Class['lemp']
}

