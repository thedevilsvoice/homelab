# homelab

[![Build Status](https://travis-ci.org/theDevilsVoice/homelab.svg?branch=master)](https://travis-ci.org/theDevilsVoice/homelab)

## setup

Debian does not have Python 3.7  in repos right now. 

- get latest [python 3.7 source from here](https://www.python.org/downloads/release/python-373/)
- ./configure --enable-optimizations
- make
- sudo make altinstall
- sudo /usr/local/bin/pip3.7 install molecule 
- sudo /usr/local/bin/pip3.7 install docker-py

## test

```
PYTHONPATH=/usr/local/lib/python3.7 /usr/local/bin/python3.7 /usr/local/bin/molecule --debug test
```
