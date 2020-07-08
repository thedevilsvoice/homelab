=============
Ansible Setup
=============

Scan subnet for raspis
----------------------

.. code-block:: bash

    nmap -sn 10.0.0.0/24

Install Ansible
---------------

.. code-block:: bash

    sudo apt install -y ansible sshpass

SSH Setup
---------

- generate a key pair on the controller machine.
- add this to /root/.ssh directory
- add the public half to each raspi in /home/pi/authorized_keys
- now test: 

.. code-block:: bash

    ansible --list-hosts raspis
    cd /etc/ansible && ansible raspis -m ping
