class vmwaretools::install inherits vmwaretools::packages {

	exec {'Extract Files':
		cwd => '/tmp',
		command => "/bin/tar xvzf ${vmwaretools::packages::toolsfile}",
		require => File['tools tgz'],
		creates => '/tmp/vmware-tools-distrib',
		timeout => 0,
	}->

	exec {'Run install Script':
	        creates => '/usr/lib/vmware-tools',
                command => "/tmp/vmware-tools-distrib/vmware-install.pl -d",
	}
}
