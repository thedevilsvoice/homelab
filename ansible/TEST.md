# Test Ansible Roles with Molecule

## Setup

```
python3 -m venv homelab_test
# because I am in fish shell
bash 
. homelab_test/bin/activate
python3 -m pip install molecule[docker]
```

## Testing

```
cd roles/webserver
molecule converge
```

## Cleanup

```
cd ../..
deactivate
rm -rf homelab_test
# because I am in fish shell
exit
```
