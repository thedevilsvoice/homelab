# VNC Client Setup

- enable VNS in raspi-config
- from the raspi desktop, change from unix auth to VNC auth.

```
ssh -L 5901:127.0.0.1:5901 -C -N -l pi x.x.x.x
```

- Once the tunnel is running, use a VNC client to connect to localhost:5901.


