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
    sudo cp homelab/ansible/hosts /etc/ansible

SSH Setup
---------

- generate a key pair on the controller machine.
- add the public half to each raspi in /home/pi/authorized_keys

.. code-block:: bash

    ssh-agent bash
    ssh-add ~/.ssh/id_rsa

- now test: 

.. code-block:: bash

    ansible --list-hosts cluster
    ansible cluster -m ping
    ansible cluster -a 'sudo apt update && sudo apt -y upgrade' 
