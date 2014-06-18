class user::virtual {
	define user_dotfile($user) {
		$source = regsubst($name, "^/home/${user}/.(.*)$", "puppet:///modules/user/${user}-\\1")
		file { $name:
			source => $source,
			owner => $user,
			group => $user,
		}
	}

	define ssh_user($key,$dotfile='',$groups='',$shell='/bin/bash') {
		user { $name:
			ensure => present,
			managehome => true,
			groups => $groups,
			shell => $shell,
		}

		file { "/home/${name}/.ssh":
			ensure => directory,
			mode => '0700',
			owner => $name,
		}

		ssh_authorized_key { "${name}_key":
			key => $key,
			type => 'ssh-rsa',
			user => $name,
			require => File["/home/${name}/.ssh"],
		}

		if $dotfile {
			$filepath = regsubst($dotfile,'^(.*)$',"/home/${name}/.\\0",'G')
			user_dotfile { $filepath:
				user => $name,
			}
		}
	}

	@ssh_user { 'aszekely':
		key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQC8sz27v+9OGveBidk3ghXKVgtGMU9PficS+NJz+5mCRh0MQKpHIlUHMwfJWQkBpQmvFKqeXGVojAeMO8Nf6BlWqP3jt50Gfi2daVOOh6tP+yPg9yILDqDKaOteAWm0uX7byOYQ0y9LNSEjhncboez8g05jTZsBegpAqIBrNlKOqzdCRKooVsJ0owuqeN0/O29XOG4MKEGJ0ojzdffOJcHiJG4+/T2YN9wYvlxhilBUcE+CFrlUzRHhZsRPTniBWdtSGT3WNSzSHkQsOGly5PXzOiL/L6HcRlYQpEopRFVmQe179mpsu8l6QLG8G9nS+lVtOPGNJ0+3V90JGdELCGi9',
		dotfile => ['forward'],
		groups => ['sudo'], #pass empty array if no groups -- []
	}
	@ssh_user { 'tgo':
		key => 'AAAAB3NzaC1kc3MAAACBAMfGrLiAVMrtg6kOdESOfAxEQ7Q6TGCN9OnX1eth21d75t6cvUZEVwgcomqlOsjuw1RBmfLmnFHtfPGIyLUYGcVBk01ggZREWwnrcPkdBVpMcy1It/bfNl1ia7a/iDOlNjt79Uc1WAEo+vJWxWWAbt4X8NExCPHQnqDNQCMXJX2VAAAAFQDpzfrv23Lfy9OXhCmevJ62OAD+VQAAAIA84nIuRrImJj5Wl0vg2JnM0tMHZgNk3OEKA10SOcm37VyZ66Nphf07rFas6ds7gBVSken5lNxdkiUyOaZWIb7KMFXe2fK2inaWiBSEUlmfOjVpyl7OxIZcBeLlrGW8AeUGOgPHrXKT7yeh9fk2Kz4GpdmZjK3E6OFbzXlq5ldJagAAAIEAo23aA9Ui0Gw1etaOofHPalz0O2FtxDOxCxetFffjusnd3yrMJ3xKZ+0L69woqCR9hxSuCie/sKdRR4BaFWtSWSSHfNw8C5Rw4GZRW6+aQLfW3RtyWTzI2Lr6okuQUp6AzzQy52GzxuuJ7e1BnIBZW7bTekjoIpY5lZo/5yqzLSg=',
		dotfile => ['forward'],
		groups => ['sudo'], #pass empty array if no groups -- []
	}
	@ssh_user { 'jversoza':
		key => 'AAAAB3NzaC1yc2EAAAABIwAAAQEA6cwR0Ij+2KhVvDjV7fipW/JPdeL+k6dkC9e+CW7dX6OQ3OM1fAnsjTVUbFG9fX7+hOjy735DIPSlYrNIzGfG3dHtDylnqb2HLewRER9fxf0ugKSfNtqW5vKrfpiG6XOalUb1vNUL+eJ/riY8e+jY5kHk0GaUZreTrtsJHG/UcrvjUAOIt3/imuZ1wL4VhuoOMo2lxHdX1RrSeB9VpBhPkrIu0vOTy8XipNoFDyIbJ9dtEGKun7127oh0uyewzvtApWo3bKhkXI0y344IFPLvagFpKhLGphaGhRD2W+vF4haieX7aZBZaDWQ8FtxU9jETpNdAjKjL45OmPobxYXVajw==',
		groups => ['sudo'], #pass empty array if no groups -- []
	}
	@ssh_user { 'pkalinsky':
		key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDoiRQUMjI0+pfYKM+Yx+AOtLec4hLSpubk454bJpG22JDHgxAJ7QiIukNhCm5ZkRCE4nXdJzGANT+Tw3IerpXAwjrflyX/4dWVG9Ij/Hnkw/aS+xIeTcROuJV5ZthlvzapprSoRKYWv42IaMKDHquo9c6PPBBDQk2RFxYt9Jf6BmXgHoTIKk25ue8VYkRyBO8R+KampLi8ZRtqVcTKMcniHaaJd1vWWJvD7cYRJpvQXN/2KoK5HJs3wk/YaOLroPcYv5X8sFfQhdUKDuM3iEudaHuNYtIX0dITWTI+aFfC6EngHcIHYuU/MldmIcLlrwfRqV8yK57p7rfVCGMNrBC/',
		groups => ['sudo'], #pass empty array if no groups -- []
	}
	@ssh_user { 'azagorodniuk':
		key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCxJsvsEyJPts+1YV19JWIy9JIROmycPnY1hhMbrnhIu8JXwLSnYb1UENf1K4r/gAREhs7VmmwmeNAhQdFRupswt4k54ggqx7FGibvphBII3nMbKO4Nufd26/3BbvKnPCcOg89Xf6Gav3YI8+k+9Y4LV1iz8BQooM7CsWculqvBG+P3g3mb+ocvm7hQrMs5zZBJXaxOtK7IXcHRw9QVY+BMWJ4vKa7QlAc4GhNXWYnlIkEvm7JLyQuFiuKYZpNFa2HbrweNkmDwiG9yMZ5+9pHeUChFF9EgOZNUNmwLNsWeY678EnHQYj+mGR8Qmz5RCqItfKatO7OHBShmXWafBF31',
		groups => ['sudo'], #pass empty array if no groups -- []
	}
}
