# music player

- mount the external drives
 - sudo mount /dev/sda1 /media/usb-lower
- enable VNC via raspi-config


```
sudo apt install mpd
amixer cset numid=1 -- -4000 # set volume to something reasonable
amixer cset numid=3 1 # set sound output to headphone jack
```