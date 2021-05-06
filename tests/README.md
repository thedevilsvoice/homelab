# measure twice, cut once

## Python Local Dev Env (Single User Nix Shell install)

To install Nix from any Linux distribution, use the following two commands.

```sh
sudo install -d -m755 -o $(id -u) -g $(id -g) /nix
curl -L https://nixos.org/nix/install | sh
```

Now you are ready to rock. 

```sh
source $HOME/.nix-profile/etc/profile.d/nix.sh
# from top level of repo
unset NIX_REMOTE || set -e NIX_REMOTE && if [ -f "requirements.txt" ]; then nix-shell; fi
python3 -m pip install tox
tox
exit
nix-collect-garbage -d
```
