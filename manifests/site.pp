class {apache:}

class {'mysql::server':
	root_password => 'salasanatahan',
}

class {ssh:}
