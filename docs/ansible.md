# Ansible Setup

- Scan subnet for raspis

```
nmap -sn 10.0.0.0/24
```

## SSH Setup

- generate a key pair on the controller machine.
- add this to /root/.ssh directory
- add the public half to eahc raspi in /home/pi/authorized_keys

- now test: ansible raspis -m ping