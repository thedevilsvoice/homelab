=============
Ansible Setup
=============

Scan subnet for raspis
----------------------

.. code-block:: bash

    nmap -sn 10.0.0.0/24

Install Ansible
---------------

Add the Ansible binary to the host you will run Ansible from.

.. code-block:: bash

    sudo apt install -y ansible sshpass
    sudo cp homelab/ansible/hosts /etc/ansible

Add *.retry to .gitignore so you don't commit those retry files.

SSH Setup
---------

- generate a key pair on the controller machine.
- add the public half to each raspi in /home/pi/authorized_keys

.. code-block:: bash

    ssh-agent bash
    ssh-add ~/.ssh/id_rsa

- now test:

.. code-block:: bash

    ansible --list-hosts raspi_cluster
    ansible raspi_cluster -m ping -e 'ansible_python_interpreter=/usr/bin/python3'
    ansible raspi_cluster -a 'apt update' --become -e 'ansible_python_interpreter=/usr/bin/python3'
    ansible raspi_cluster -a 'apt -y upgrade' --become -e 'ansible_python_interpreter=/usr/bin/python3'

Test Ansible Roles w/Molecule
-----------------------------

Install Molecule and add it to desired roles.

Run it like so:

.. code-block:: bash

   python3 -m venv venv_molecule
   . venv_molecule/bin/activate
   python3 -m pip install molecule[docker]
   cd roles/cluster && molecule check
   cd roles/webserver && molecule test
   cd ../..
   deactivate
   rm -rf homelab/ansible/venv_molecule

Setting Python Version for Molecule
-----------------------------------

You can set the ansible_python_interpreter by adding a
stanza to "provisioner" in molecule.yml. Make sure you chance
'my_instance' to match the 'name:' you set in platforms.

.. code-block:: bash

   # molecule.yml
   platforms:
   - name: my_instance
       box: my_box
   provisioner:
   name: ansible
   lint:
       name: ansible-lint
   inventory:
       host_vars:
       my_instance:
           ansible_python_interpreter: "/home/core/bin/python"
