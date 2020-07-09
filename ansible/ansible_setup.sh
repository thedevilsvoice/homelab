
ssh-agent bash
ssh-add ~/.ssh/id_rsa
# how does this stupid route keep showing up
sudo route del -net 0.0.0.0 gw 10.10.15.254
# now test it
ansible cluster -m ping

ansible cluster -a 'sudo route del -net 0.0.0.0 gw 10.10.15.254'
