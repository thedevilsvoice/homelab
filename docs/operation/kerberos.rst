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
    addprinc -randkey HTTP/pa220.lab.bitsmasher.net@LAB.BITSMASHER.NET
    ktadd -k pa220.keytab HTTP/pa220.lab.bitsmasher.net@LAB.BITSMASHER.NET
    addprinc -randkey host/odroid-c1.lab.bitsmasher.net@LAB.BITSMASHER.NET
    addprinc -randkey host/lanparty.lab.bitsmasher.net@LAB.BITSMASHER.NET
    addpol -minlength 8 -maxlife 7776000 -history 5 users
    getpol users
    ank -policy users franklin
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

User
====

kinit franklin -X X509_user_identity=FILE:~/.ssh/franklin-cert.pem,~/.ssh/franklin-key.pem