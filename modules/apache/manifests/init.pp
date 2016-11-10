class apache {
	Package { ensure => "installed", allowcdrom => "true", }

	package { apache2: }
	package { libapache2-mod-php:}
	
	file { "/var/www/html/index.php":
		content => template("apache2/index.php"),
	}

	file { "/var/www/html/index.html":
		ensure => "absent",
	}

	file { "/etc/apache2/mods-enabled/userdir.conf":
		ensure => "link",
		target => "/etc/apache2/mods-available/userdir.conf",
		notify => Service["apache2"],
		require => Package["apache2"],
	}

	file { "/etc/apache2/mods-enabled/userdir.load":
		ensure => "link",
		target => "/etc/apache2/mods-available/userdir.load",
		notify => Service["apache2"],
		require => Package["apache2"],
	}

	service {"apache2":
		ensure => "running",
		enable => "true",
		provider => "systemd",
		require => Package["apache2"],
	}
}
