define lemp::vhost ($root = '/usr/share/nginx/html', $index = 'index.html index.htm', $server_name = 'localhost', $ssl = 'off', $ssl_certificate = 'cert.pem', $ssl_certificate_key 'cert.key', $ssl_session_timeout = '5m' ) {

	require lemp

	#handle if PHP is enabled, choose between unix socket or fastcgi server on 127.0.0.1:9000

	#deny access to .htaccess

	#handle SSL and certificates, dependencies on the files at the end of the template

	file { "/etc/nginx/sites-enabled/$::lemp::vhost::server_name" :
		ensure => present,
	}

}
