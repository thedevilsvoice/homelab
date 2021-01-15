https://help.ubuntu.com/community/Kerberos

Start the kadmin tool

.. code-block:: bash

    kadmin.local -p admin/admin

Server
======

Create the LDAP principal & keytab

.. code-block:: bash

    addpol -minlength 8 -maxlife 7776000 -history 5 users
    getpol users
    ank -policy users franklin
    listprincs

Client
======

Realm is LAB.BITSMASHER.NET

Ansible does this part:

.. code-block:: bash

   sudo apt install krb5-user krb5-config libpam-krb5 libpam-ccreds
   sudo apt install ldap-utils

Now set up the keytab for the host. Log in to the host to Create
/etc/krb5.keytab file in place. Must be done as root user (not sudo)

.. code-block:: bash

   sudo -i
   kinit root/admin
   kadmin
   addprinc -randkey host/head1.lab.bitsmasher.net
   addprinc -randkey ldap/head1.lab.bitsmasher.net
   ktadd host/grimoire.lab.bitsmasher.net ldap/grimoire.lab.bitsmasher.net
   (quit)
   klist -ke /etc/krb5.keytab

User
====

kinit franklin -X X509_user_identity=FILE:~/.ssh/franklin-cert.pem,~/.ssh/franklin-key.pem
