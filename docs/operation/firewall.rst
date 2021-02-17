ansible-galaxy install paloaltonetworks.paloaltonetworks
ansible-galaxy collection install paloaltonetworks.panos
ansible-galaxy collection install -r collections/requirements.yml

ansible-playbook -i firewalls firewalls.yml --ask-vault-pass -e 'ansible_python_interpreter=/usr/bin/python3'
