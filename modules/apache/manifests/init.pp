class apache {
	Package { ensure => "installed", allowcdrom => "true", }

	package { apache2: }
	package { libapache2-mod-php:}
	
	file { "/var/www/html/index.php":
		content => template("apache/index.php"),
	}

	file { "/var/www/html/index.html":
		ensure => "absent",
		require => Package["apache2"],
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
		require => Package["apache2"],
		notify => Service["apache2"],
	}

	file { "/etc/apache2/mods-available/php7.0.conf":
		content => template("apache/php7.0.conf"),
		require => Package["libapache2-mod-php"],
		notify => Package["apache2"],
	}

	file { "/etc/skel/public_html":
		ensure => "directory",
	}

	file { "/etc/skel/public_html/index.php":
		content => template("apache/public_html/index.php"),
		require => Package["apache2"],
	}

	service {"apache2":
		ensure => "running",
		enable => "true",
		provider => "systemd",
		require => Package["apache2"],
	}
}
