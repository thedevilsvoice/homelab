# Kubernetes

## Installation

```sh
TOKEN=$(sudo kubeadm token generate)
sudo kubeadm init --pod-network-cidr=192.168.0.0/16 --token=${TOKEN}
mkdir ~/.kube
sudo cp /etc/kubernetes/admin.conf ~/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config
kubectl -n kube-system get pods --watch
```

Confirm that you now have a node in your cluster with the following command

```sh
kubectl get nodes -o wide
```

### Enable pod scheduling on master node 

This is probably not a good idea since kubeapi-server and CNI take so much CPU. 

```sh
kubectl taint nodes --all node-role.kubernetes.io/master-
```

## Netowrking Setup

If you go and look at the quickstart guide of Calico, you’ll notice it tells 
you to deploy Calico with the Tigera operator. Unfortunately, it doesn’t 
support ARM. Therefore, we take the traditional approach to setup Calico.

From head1 or head2:

## Get calicoctl

Will not run from 32 bit head nodes. 

```sh
cd ~/bin && wget https://github.com/projectcalico/calicoctl/releases/download/v3.18.1/calicoctl-linux-arm64  && chmod 755 calicoctl
```

```sh
curl https://docs.projectcalico.org/manifests/calico.yaml -O
# fix up the calico.yml for arm64
kubectl apply -f calico.yaml
kubectl -n kube-system get pods --watch
kubectl -n kube-system get deploy
sudo tail -f /var/log/daemon.log 
```

To test Calico, we can spin up some test containers and do a ping test.

### start two containers

```sh
$ kubectl run pingtest1 --image=busybox -- sleep infinity
$ kubectl run pingtest2 --image=busybox -- sleep infinity
```

### check their IP within the cluster

```sh
$ kubectl get pod -o wide
NAME        READY   STATUS    RESTARTS   AGE   IP               NODE                        NOMINATED NODE   READINESS GATES
pingtest1   1/1     Running   0          15m   192.168.20.193   pic04.sg-home.shawnliu.me   <none>           <none>
pingtest2   1/1     Running   0          66s   192.168.20.65    pic03.sg-home.shawnliu.me   <none>           <none>
```

### ping test

```sh
$ kubectl exec -it pingtest1 -- ping -c5 192.168.20.65
PING 192.168.20.65 (192.168.20.65): 56 data bytes
64 bytes from 192.168.20.65: seq=0 ttl=62 time=0.777 ms
64 bytes from 192.168.20.65: seq=1 ttl=62 time=0.793 ms
64 bytes from 192.168.20.65: seq=2 ttl=62 time=0.756 ms
```

### route check

```sh
$ ip route get 192.168.20.193
192.168.20.193 via 192.168.10.14 dev tunl0 src 192.168.20.0 uid 1000
```

### cleanup

```sh
kubectl delete pod pingtest1
kubectl delete pod pingtest2
```

## Helm Setup

```sh
wget https://get.helm.sh/helm-v3.5.3-linux-arm64.tar.gz
helm repo add stable https://charts.helm.sh/stable
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm repo list
```

Find some goodies: 

```sh
helm search repo bitnami
helm install my-release bitnami/chart-name
```

## Dashboard Setup

```sh
helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
kubectl config get-contexts
kubectl config set-context --current --namespace=kube-system
kubectl config get-contexts
kubectl create serviceaccount dashboard -n kube-system
helm install dashboard kubernetes-dashboard/kubernetes-dashboard \
  -n kubernetes-dashboard --create-namespace
kubectl get pods -o wide -n kubernetes-dashboard
kubectl describe serviceaccount dashboard -n kubernetes-dashboard | grep Tokens
kubectl describe secret dashboard-kubernetes-dashboard-token-XXXXX -n kubernetes-dashboard
```

Get the Kubernetes Dashboard URL by running:

```sh
export POD_NAME=$(kubectl get pods -n kubernetes-dashboard -l "app.kubernetes.io/name=kubernetes-dashboard,app.kubernetes.io/instance=dashboard" -o jsonpath="{.items[0].metadata.name}")
kubectl proxy --address='0.0.0.0' --accept-hosts='^*$'
http://10.10.12.0:8001/api/v1/namespaces/kubernetes-dashboard/services/https:dashboard-kubernetes-dashboard:https/proxy/#/login
```

## Operation

```sh
cd workspace/homelab/ansible
ssh-add ~/.ssh/id_rsa
ansible cluster -m ping --become -e 'ansible_python_interpreter=/usr/bin/python3'
for h in node{0..3}; do ssh pi@$h kubeadm version; done
for h in node{0..3}; do ssh pi@$h systemctl is-active kubelet; done
for h in node{0..3}; do ssh pi@$h sudo apt upgrade -y --allow-change-held-packages kubeadm kubectl kubelet; done
```

From node0:

```sh
kubectl cluster-info
kubeadm upgrade plan
kubectl -n kube-system get cm kubeadm-config -oyaml
kubectl describe node node0
kubectl taint nodes --all node-role.kubernetes.io/master-
kubectl describe node | grep -i taint
```

## Troubleshooting

Processes:

```sh
systemctl status docker
systemctl status kubelet
netstat -pnlt | grep 6443
```

```sh
kubectl get pods --all-namespaces -o wide
kubectl logs --namespace kube-system kube-flannel-ds-arm-4zq4g
env | grep -i kube
kubectl version --client
kubectl get node
kubectl get pods --all-namespaces -o jsonpath="{..image}" | tr -s '[[:space:]]' '\n' | sort |
 uniq -c
```

## Checking logs

```sh
kubectl get pods -n kube-system
kubectl logs pod/kube-flannel-ds-arm-9sjt6 -n kube-system
```

## kube-apiserver

if you install K8S with kubeadm, the kubeapi-server 
is running as a pod on the master node

```
kubectl get pods -n kube-system
```

So, because you can't restart pods in K8S you'll have to delete it:

```
kubectl delete pod/kube-apiserver-node0 -n kube-system
```

And a new pod will be created immediately.

## Database

```sh
kubectl -n kube-system exec -it etcd-node0 -- sh -c "ETCDCTL_API=3 ETCDCTL_CACERT=/etc/kubernetes/pki/etcd/ca.crt ETCDCTL_CERT=/etc/kubernetes/pki/etcd/server.crt ETCDCTL_KEY=/etc/kubernetes/pki/etcd/server.key etcdctl --endpoints=https://127.0.0.1:2379 snapshot save /var/lib/etcd/snapshot.db"
```

## Remove

```sh
kubectl drain <node name> --delete-local-data --force --ignore-daemonsets
kubectl delete node <node name>
kubeadm reset
```

