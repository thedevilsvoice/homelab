
# ssh-agent bash
ssh-add ~/.ssh/id_rsa

# now test it
ansible cluster -m ping

ansible-playbook playbook.yml -i hosts --become -e 'ansible_python_interpreter=/usr/bin/python3'
