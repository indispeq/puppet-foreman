class nagios::nrpe {

	$monitor_ips = '192.168.228.104'

        file { '/etc/nagios/nrpe_local.cfg':
                notify => Service['nagios-nrpe-server'],
                content => template('nagios/nrpe_local.cfg.erb'),
                owner => nagios,
                group => nagios,
        }

        file { '/etc/nagios/nrpe.cfg':
                notify => Service['nagios-nrpe-server'],
                source => 'puppet:///modules/nagios/nrpe.cfg',
                owner => nagios,
                group => nagios,
        }

 
    package { [ 'nagios-nrpe-server', 'nagios-plugins' ]:
        ensure      => present,
    }
 
    service { 'nagios-nrpe-server':
        ensure      => running,
        enable      => true,
        require     => Package[ [ 'nagios-nrpe-server', 'nagios-plugins' ] ],
    }
}

