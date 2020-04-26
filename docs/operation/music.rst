============
music player
============

External drives
---------------

Three externals are mounted:

.. code-block:: bash

    pi@raspi4-a:~ $ df -h | grep sd
    /dev/sda1       110G   61M  104G   1% /mnt/usb3-upper
    /dev/sdb1       220G   70G  142G  34% /mnt/usb3-lower
    /dev/sdc1       2.8T  888G  1.9T  32% /mnt/external




Software
--------

.. code-block:: bash

    sudo apt install mpd
    amixer cset numid=1 -- -4000 # set volume to something reasonable
    amixer cset numid=3 1 # set sound output to headphone jack
