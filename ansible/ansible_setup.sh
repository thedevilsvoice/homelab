if [ ! -d "/etc/ansible" ]; then
  mkdir /etc/ansible
fi
cp ansible.cfg /etc/ansible

# for FISH shell, skip the "env" for BASH
env ANSIBLE_CONFIG=/etc/ansible/ansible.cfg ansible-galaxy install -r requirements.yml
env ANSIBLE_CONFIG=/etc/ansible/ansible.cfg ansible-galaxy collection install paloaltonetworks.panos

# ssh-agent bash
ssh-add ~/.ssh/id_rsa

# now test it
ansible raspi_cluster -m ping --become -e 'ansible_python_interpreter=/usr/bin/python3'

ansible-playbook playbook.yml -i hosts --become -e 'ansible_python_interpreter=/usr/bin/python3'


# Firewall
# Examples: https://github.com/PaloAltoNetworks/ansible-pan/tree/master/examples
ansible-playbook -i firewalls firewalls.yml --ask-vault-pass -e 'ansible_python_interpreter=/usr/bin/python3'
