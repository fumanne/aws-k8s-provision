**roles sequence:**

    base-package  ->  os ->  docker -> ca-init -> ca-distrubution -> etcd -> kube-apiserver -> kube-controller-manager -> kube-scheduler -> 
    boostrap-kubeconfig ->  kube-proxy -> kubelet ->  calico | flannel | aws-vpc-cni -> default-cni ->  helm -> aws-ebs -> admin-serviceaccount -> charts
    
base-package: 初始化目录 以及安装package，iptables

os: 调整kernel 参数,selinux 配置等

docker: 安装docker service

ca-init: 所有组件用的证书初始化 以及生成所用的kubeconfig 配置文件

ca-distrubution:  分发证书

etcd: 安装etcd service

kube-apiserver: 安装kube-apiserver service

kube-controller-manager: 安装 kube-controller-manager service

kube-scheduler: 安装kube-scheduler service

kube-porxy: 安装kube-proxy service

kubelet: 安装 kubelet service

boostrap-kubeconfig: 分发bootstrap kubeconfig 文件

flannel: 部署flannel 

calico: 部署calico

helm: 部署helm

aws-ebs: 部署 aws 的stroage class

default-cni: 删除一开始kubeket 启动时候的cni 配置

clean: 删除k8s 所有资源.. 用于重建k8s

charts: 使用helm3 安装的k8s资源 比如(metrics-server, coredns, prometheus 等等这种可以自行添加)

admin-serviceaccount: 创建以cluster-admin 为权限 名为admin 的serviceaccount的用户(已供远程kubectl 设置credentials 后访问)
