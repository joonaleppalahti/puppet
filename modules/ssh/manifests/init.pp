class ssh {
	Package { ensure => "installed", allowcdrom => "true", }

	package { ssh: }
	
	file { "/etc/ssh/sshd_config":
		content => template("ssh/sshd_config"),
		notify => Service["ssh"],
	}
	
	service {"ssh":
		ensure => "running",
		enable => "true",
		provider => "systemd",
		require => Package["ssh"],
	}
}
