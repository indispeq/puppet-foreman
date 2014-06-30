#need to move all this to hiera once it is working

class lemp::config::nginx ( $worker_processes = '4', $worker_connections = '768', $keepalive_timeout = '65' )  {

	file { '/etc/nginx/nginx.conf':
	        require => Class['lemp::install::nginx'],
		content => template('lemp/nginx.conf.erb'),
		notify => Class['lemp::service::nginx'],
	}


}

define lemp::vhost ($site_name = 'localhost', $root = '/usr/share/nginx/html', $index = 'index.html index.htm', $server_name = 'localhost', $ssl = 'off', $ssl_certificate = 'cert.pem', $ssl_certificate_key = 'cert.key', $ssl_session_timeout = '5m' ) {
	require lemp

	#handle if PHP is enabled, choose between unix socket or fastcgi server on 127.0.0.1:9000

	#deny access to .htaccess


	#handle SSL and certificates, dependencies on the files at the end of the template

	file { "/etc/nginx/sites-enabled/$::lemp::vhost::site_name" :
		ensure => present,
	}

	file { "/var/www/$::lemp::vhost::site_name" :
		ensure => directory,
		owner => 'www-data',
		group => 'www-data',
	}->

	file { "/var/www/$::lemp::vhost::site_name/html" :
		ensure => directory,
		owner => 'www-data',
		group => 'www-data',
	}

}
