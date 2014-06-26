class vmwaretools::install {
        $kernelheaders = "linux-headers-${::kernelrelease}"

        #This worked on ESXi 5.1u1
        #$toolsfile = 'VMwareTools-9.0.5-1065307.tar.gz'

        #This guy is for 5.5u1
        $toolsfile = 'VMwareTools-9.0.11-1743336.tar.gz'

	package { 'build-essential':
                ensure => present,
        }->

        package { "$kernelheaders":
                ensure => installed,
        }->

        file {'tools tgz':
                path => "/root/$toolsfile",
                ensure => present,
                source => "puppet:///modules/vmwaretools/$toolsfile",
        }-> 

	exec {'Extract Files':
		cwd => '/root',
		command => "/bin/tar xvzf $toolsfile",
		require => File['tools tgz'],
		creates => '/root/vmware-tools-distrib',
		timeout => 0,
	}->

	exec {'Run install Script':
	        creates => '/usr/lib/vmware-tools',
                command => "/root/vmware-tools-distrib/vmware-install.pl -d",
	}
}
