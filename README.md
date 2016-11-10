# Puppet containing multiple modules

## Apache and PHP

* Installs Apache2
* Changes default webpage
* Enables userdir
* Enables PHP in main directory
* Enables PHP in user directories
* Adds public_html/index.php to /etc/skel

## MySQL

* Installs MySQL
* Sets root password as defined in site.pp

## SSH and UFW

* Installs SSH
* Sets listening port to 5555
* Allow 5555/tcp
* Allow 80/tcp
* Allow 8140/tcp
