https://help.ubuntu.com/community/Kerberos

Start the kadmin tool

.. code-block:: bash

    kadmin.local -p admin/admin

Server
======

Create the LDAP principal & keytab

.. code-block:: bash

    kadmin.local
    addprinc -randkey ldap/odroid-c1.lab.bitsmasher.net@LAB.BITSMASHER.NET
    ktadd -k ldap.keytab ldap/odroid-c1.lab.bitsmasher.net@LAB.BITSMASHER.NET
    listprincs

Set up the keytab

.. code-block:: bash

    mv ldap.keytab /etc/ldap
    chown openldap:openldap /etc/ldap/ldap.keytab
    chmod 640 /etc/ldap/ldap.keytab

Client
======

sudo apt install krb5-user krb5-config libpam-krb5 libpam-ccreds 

apt install ldap-utils

Realm is LAB.BITSMASHER.NET