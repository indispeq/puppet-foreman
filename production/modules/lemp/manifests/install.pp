class lemp::install::nginx {
	package { 'nginx' :
		ensure => installed,
	}
}


