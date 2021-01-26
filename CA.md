### etcd: 使用 ca.pem, etcd-key.pem, etcd.pem

### kube-apiserver: 使用 ca.pem, kubernetes-key.pem, kubernetes.pem

### kubelet: 使用 ca.pem

### kube-proxy: 使用 ca.pem, kube-proxy-key.pem, kube-proxy.pem

### kubectl: 使用 ca.pem, admin-key.pem, admin.pem

### kube-controller-manager: 使用 ca.pem, kube-controller-manager-key.pem, kube-controller-manager.pem

### kube-scheduler: 使用 ca.pem, kube-scheduler-key.pem, kube-scheduler.pem

### aggregator-proxy: 使用ca.pem, aggregator-proxy-key.pem, aggregator-proxy.pem


##### etcdctl command:

    etcdctl --ca-file /etc/kubernetes/ssl/ca.pem --cert-file /etc/kubernetes/ssl/etcd.pem --key-file /etc/kubernetes/ssl/etcd-key.pem member list