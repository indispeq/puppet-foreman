class nagios {
 class { '::nagios::monitor': } ->
 Class['nagios']
}
