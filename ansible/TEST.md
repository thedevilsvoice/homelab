# Test Ansible Roles with Molecule

## Setup

```bash
python3 -m venv homelab_test
# because I am in fish shell
bash
. homelab_test/bin/activate
python3 -m pip install molecule[docker]
```

## Testing

```bash
cd roles/cluster && molecule test
cd roles/webserver && molecule test
```

## Cleanup

```bash
cd ../..
deactivate
rm -rf homelab_test
# because I am in fish shell
exit
```

## Setting interpreter

You might see this warning when running molecule

```bash
[WARNING]: Distribution Ubuntu 20.04 on host cluster-node should use
/usr/bin/python3, but is using /usr/bin/python, since the discovered platform
python interpreter was not present. See https://docs.ansible.com/ansible/2.10/r
eference_appendices/interpreter_discovery.html for more information.
```

You can set the ansible_python_interpreter by adding a
stanza to "provisioner" in molecule.yml. Make sure you chance
'my_instance' to match the 'name:' you set in platforms.


```bash
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
```
