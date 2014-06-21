class ssh {
 class { '::ssh::install': } ->
 class { '::ssh::config': } ->
 class { '::ssh::service': } ->
 Class['ssh']
}

class ssh::hostkeys {

	@@sshkey { "${::fqdn}_dsa":
		host_aliases => [ $::fqdn, $::hostname, $::ipaddress ],
		type => dsa,
		key => $::sshdsakey,
	}

	@@sshkey { "${::fqdn}_rsa":
		host_aliases => [ $::fqdn, $::hostname, $::ipaddress ],
		type => rsa,
		key => $::sshrsakey,
	}

}

class ssh::knownhosts {
	Sshkey <<| |>> { ensure => present }
}
