http://acidx.net/wordpress/2014/04/basic-openldap-installation-configuration/

sudo -i
apt-get update
apt-get upgrade
apt-get install slapd ldap-utils
lsof -Pni :389

dpkg-reconfigure slapd

ldapsearch -x -W -D cn=admin,dc=lab,dc=bitsmasher,dc=net -b dc=lab,dc=bitsmasher,dc=net -LLL
