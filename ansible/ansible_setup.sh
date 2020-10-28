
# ssh-agent bash
ssh-add ~/.ssh/id_rsa

# now test it
ansible cluster -m ping --become -e 'ansible_python_interpreter=/usr/bin/python3'

ansible-playbook playbook.yml -i hosts --become -e 'ansible_python_interpreter=/usr/bin/python3'
