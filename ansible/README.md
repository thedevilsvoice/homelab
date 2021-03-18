```bash
sudo apt install -y ansible sshpass
sudo cp homelab/ansible/hosts /etc/ansible
if [ ! -d "/etc/ansible" ]; then
  mkdir /etc/ansible
fi
cp ansible.cfg /etc/ansible
```

```fish
# for FISH shell, skip the "env" for BASH
env ANSIBLE_CONFIG=/etc/ansible/ansible.cfg ansible-galaxy install -r requirements.yml
env ANSIBLE_CONFIG=/etc/ansible/ansible.cfg ansible-galaxy collection install paloaltonetworks.panos
```

Use Kerberos auth with my own user instead of "pi" user. 

```bash
#ssh-agent bash
#ssh-add ~/.ssh/id_rsa
kinit franklin
```

```bash
# now test it
ansible --list-hosts raspi_cluster
ansible raspi_cluster -m ping -e 'ansible_python_interpreter=/usr/bin/python3'
```

```bash
ansible raspi_cluster -a 'apt update' --become -e 'ansible_python_interpreter=/usr/bin/python3'
ansible raspi_cluster -a 'apt -y upgrade' --become -e 'ansible_python_interpreter=/usr/bin/python3'
ansible-playbook playbook.yml -i /etc/ansible/hosts --become -e 'ansible_python_interpreter=/usr/bin/python3'
```

# Firewall
# Examples: https://github.com/PaloAltoNetworks/ansible-pan/tree/master/examples
ansible-playbook -i firewalls firewalls.yml --ask-vault-pass -e 'ansible_python_interpreter=/usr/bin/python3'
