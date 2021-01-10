Operating the Cluster
=====================

Setup User
**********



.. code-block:: bash

   mkdir ~/.kube
   sudo cp /etc/kubernets/admin.conf ~/.kube/config
   chown user:grp ~/.kube/config

From outside the cluster
************************

.. code-block:: bash
   cd workspace/homelab/ansible
   ssh-add ~/.ssh/id_rsa
   ansible cluster -m ping --become -e 'ansible_python_interpreter=/usr/bin/python3'
   for h in node{0..3}; do ssh pi@$h kubeadm version; done
   for h in node{0..3}; do ssh pi@$h systemctl is-active kubelet; done
   for h in node{0..3}; do ssh pi@$h sudo apt upgrade -y --allow-change-held-packages kubeadm kubectl kubelet; done


From the head node
******************

.. code-block:: bash

   kubectl cluster-info
   kubeadm upgrade plan
   kubectl -n kube-system get cm kubeadm-config -oyaml
   kubectl describe node node0
   kubectl taint nodes --all node-role.kubernetes.io/master-
   kubectl describe node | grep -i taint


Create the UI
*************

sudo kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml


.. code-block:: bash

    ssh-add ~/.ssh/id_rsa
    ssh pi@node0
    kubectl get nodes
    kubectl get namespaces
    kubectl create namespace kube-verify
    kubectl get namespaces

.. code-block:: bash

    cat <<EOF | kubectl create -f -
    apiVersion: apps/v1
    kind: Deployment
    metadata:
    name: kube-verify
    namespace: kube-verify
    labels:
        app: kube-verify
    spec:
    replicas: 3
    selector:
        matchLabels:
        app: kube-verify
    template:
        metadata:
        labels:
            app: kube-verify
        spec:
        containers:
        - name: nginx
            image: quay.io/clcollins/kube-verify:01
            ports:
            - containerPort: 8080
    EOF

.. code-block:: bash

    kubectl get all -n kube-verify

.. code-block:: bash

    # Create a service for the deployment
    $ cat <<EOF | kubectl create -f -
    apiVersion: v1
    kind: Service
    metadata:
    name: kube-verify
    namespace: kube-verify
    spec:
    selector:
        app: kube-verify
    ports:
        - protocol: TCP
        port: 80
        targetPort: 8080
    EOF

.. code-block:: bash

    kubectl get -n kube-verify service/kube-verify
    sudo docker run -it --rm --privileged --net=host   -v /:/rootfs -v $CONFIG_DIR:$CONFIG_DIR -v $LOG_DIR:/var/log   k8s.gcr.io/node-test-arm:0.2

Kubernetes Dashboard
********************

.. code-block:: bash

   kubectl create namespace kubernetes-dashboard
   curl https://raw.githubusercontent.com/kubernetes/dashboard/v2.1.0/aio/deploy/recommended.yaml --output kubernetes-dashboard.yaml

Comment out the `imagePullPolicy: Always` in the manifest file under the kubernetes-dashboard deployment block.

.. code-block:: bash

   kubectl apply -f kubernetes-dashboard.yaml
   watch kubectl get pods -n kubernetes-dashboard
   kubectl get pods --all-namespaces
   kubectl -n kubernetes-dashboard logs kubernetes-dashboard-b8995f9f8-w5zn7 -f
   screen kubectl proxy
   kubectl -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret | grep admin-user | awk '{print $1}')

ssh -L 8001:127.0.0.1:8001 franklin@10.10.12.0

http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#/overview?namespace=_all
