# Cluster Operation

The cluster has 4 nodes.

## OpenMPI

- munge
  - test it: `munge -n | unmunge`
- SLURM

```bash
sinfo
srun --nodes=3 hostname
srun --ntasks=3 hostname
srun --nodes=2 --ntasks-per-node=3 hostname
squeue
```

- R

```bash
srun --nodes=3 R --version
```

- OpenMPI

```c
#include <stdio.h>
#include <mpi.h>
int main(int argc, char** argv){
    int node;
    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &node);
    printf("Hello World from Node %d!\n", node);
    MPI_Finalize();
}
```

Now compile: `mpicc ./hello_mpi.c -o hello_mpi`

```bash
#!/bin/bash

cd $SLURM_SUBMIT_DIR

# Print the node that starts the process
echo "Master node: $(hostname)"

# Run our program using OpenMPI.
# OpenMPI will automatically discover resources from SLURM.
mpirun /mnt/clusterfs/hello_mpi
```

## Python

```bash
mkdir /mnt/clusterfs/build && cd /mnt/clusterfs/build
wget https://www.python.org/ftp/python/3.9.0/Python-3.9.0.tgz
tar xzf Python-3.9.0.tgz
cd Python-3.9.0
./configure --enable-optimizations --prefix=/mnt/clusterfs/usr --with-ensurepip=install
```

Create sub_build_python.sh:

```bash
#!/bin/bash
#SBATCH --nodes=4
#SBATCH --ntasks-per-node=4
#SBATCH --nodelist=node[0-3]
cd $SLURM_SUBMIT_DIR
make -j4
```

Now run it: 

`sbatch sub_build_python.sh`

It only needs to install to the shared filesystem from one node:

```bash
#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --nodelist=node1

#cd $SLURM_SUBMIT_DIR

make install
```

Now: `sub_install_python.sh`

Test out the new python3:

```bash
srun --nodes=4 /mnt/clusterfs/usr/bin/python3 -c "import socket; print('Hello from {}'.format(socket.gethostname()))"
srun --nodes=1 /mnt/clusterfs/usr/bin/pip3 --version
```

Create the file sub_install_pip.sh:

```bash
#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1

/mnt/clusterfs/usr/bin/pip3 install numpy mpi4py
```

Run this with sudo: `sudo sbatch ./sub_install_pip.sh`

## Kubernetes

## Hadoop

```bash
mkdir /mnt/clusterfs/hadoop
wget https://apache.claz.org/hadoop/common/hadoop-3.3.0/hadoop-3.3.0.tar.gz
```