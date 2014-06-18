
class vmwaretools::packages {

	package { 'build-essential':
		ensure => present,
	}

	$kernelheaders = "linux-headers-${::kernelrelease}"

	package { "$kernelheaders":
		ensure => installed,
	}

	#This worked on ESXi 5.1u1
        #$toolsfile = 'VMwareTools-9.0.5-1065307.tar.gz'

        #This guy is for 5.5u1
        $toolsfile = 'VMwareTools-9.0.11-1743336.tar.gz'


	file {'tools tgz':
		path => "/tmp/$toolsfile",
		ensure => present,
		source => "puppet:///modules/vmwaretools/$toolsfile",
	}
}
