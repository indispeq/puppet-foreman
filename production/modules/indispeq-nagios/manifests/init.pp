class indispeq-nagios::install {
    package { [ 'nagios3', 'nagios-plugins', 'nagios-nrpe-plugin' ]:
        ensure  => present,
    }
}

class indispeq-nagios::service {
 
    exec { 'fix-permissions':
        command     => "find /etc/nagios3/conf.d -type f -name '*cfg' | xargs chmod +r",
        refreshonly => true,
    } ->
 
    service { 'nagios':
        ensure      => running,
        enable      => true,
        require     => Class[ 'indispeq-nagios::server' ],
    }
}

class indispeq-nagios::import {
 
    Nagios_host <<||>> {
        require => Class[ 'indispeq-nagios::install' ],
        notify  => Class[ 'indispeq-nagios::service' ]
    }
 
    Nagios_service <<||>> {
        require => Class[ 'indispeq-nagios::install' ],
        notify  => Class[ 'indispeq-nagios::service' ]
    }
}

class indispeq-nagios::export {
 
    @@nagios_host { $::hostname :
        ensure              => present,
        address             => $::ipaddress,
        use                 => 'generic-host',
        check_command       => 'check-host-alive',
        hostgroups          => 'all-servers',
        target              => "/etc/nagios3/conf.d/${::hostname}.cfg",
    }
 
    @@nagios_service { "${::hostname}_check-load":
        ensure              => present,
        use                 => 'generic-service',
        host_name           => $::hostname,
        service_description => 'Current Load',
        check_command       => 'check_nrpe!check_load',
        target              => "/etc/nagios3/conf.d/${::hostname}.cfg",
    }
 
    @@nagios_service { "${::hostname}_check-disk":
        ensure              => present,
        use                 => 'generic-service',
        host_name           => $::hostname,
        service_description => 'hda1 disk usage',
        check_command       => 'check_nrpe!check_hda1',
        target              => "/etc/nagios3/conf.d/${::hostname}.cfg",
    }
}

class indispeq-nagios::nrpe {
 
    package { [ 'nagios-nrpe-server', 'nagios-plugins' ]:
        ensure      => present,
    }
 
    service { 'nagios-nrpe-server':
        ensure      => running,
        enable      => true,
        require     => Package[ 'nagios-nrpe-server', 'nagios-plugins' ] ],
    }
}
