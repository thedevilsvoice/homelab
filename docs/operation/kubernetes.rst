.. code-block:: bash

    ssh-add ~/.ssh/id_rsa
    ssh pi@node0
    sudo kubectl get nodes
    sudo kubectl get namespaces
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