Set up these packages on fileserve[*] hosts. 

AFS Cell: lab.bitsmasher.net
Size of AFS cache in kB: 50000

.. code-block:: bash

   apt install build-essential dkms raspberrypi-kernel-headers
   apt install linux-headers-`uname -r`
   apt install openafs-modules-dkms
