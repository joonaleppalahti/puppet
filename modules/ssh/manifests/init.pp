class ssh {
	Package { ensure => "installed", allowcdrom => "true", }

	package { ssh: }
	
	file { "/etc/ssh/sshd_config":
		content => template("ssh/sshd_config.erb"),
		notify => Service["ssh"],
	}
	
	service {"ssh":
		ensure => "running",
		enable => "true",
		provider => "systemd",
		require => Package["ssh"],
	}

	file { "/etc/ufw/user.rules":
		content => template("ssh/user.rules"),
	}

	file { "/etc/ufw/user6.rules":
		content => template("ssh/user6.rules"),
	}

	exec { "ufw enable":
		path => "/bin/:/usr/bin/:/sbin/:/usr/sbin/",
		unless => 'sudo ufw status verbose|grep "Status: active"',
	}

}
