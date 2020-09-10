#!/usr/bin/env bash

export DOCKER_VER=19.03.9
export DOCKER_COMPOSE=1.26.1
export K8S_VER=v1.19.1
export ETCD_VER=v3.3.17
export CNI_VER=v0.8.6
export HELM=v3.2.4
export CALICOCTL=v3.14.1

HOME_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
pushd ${HOME_DIR} >/dev/null

WGET_CMD="wget -nv -P ."
ECHO_CMD="echo"

${ECHO_CMD} "\nClean Download Dir, Only retain this scripts"
find . -not -name 'download.sh' -delete

${ECHO_CMD} "\n----Download ca tools:"
${WGET_CMD} https://pkg.cfssl.org/R1.2/cfssl_linux-amd64
${WGET_CMD} https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64
${WGET_CMD} https://pkg.cfssl.org/R1.2/cfssl-certinfo_linux-amd64
mv -f cfssl_linux-amd64             ../roles/base-package/files/cfssl
mv -f cfssljson_linux-amd64         ../roles/base-package/files/cfssljson
mv -f cfssl-certinfo_linux-amd64    ../roles/base-package/files/cfssl-certinfo

${ECHO_CMD} "\n----Download docker binary:"
${WGET_CMD} https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VER}.tgz

${ECHO_CMD} "\n----Download docker-compose:"
${WGET_CMD} https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE}/docker-compose-Linux-x86_64

mv -f docker-compose-Linux-x86_64 ../roles/docker/files/docker-compose

if [[ -f "docker-${DOCKER_VER}.tgz" ]]; then
    ${ECHO_CMD} "\n----extracting docker binaries..."
    tar zxf docker-${DOCKER_VER}.tgz
    mv -f docker/docker*                    ../roles/docker/files/
    mv -f docker/containerd                 ../roles/docker/files/containerd
    mv -f docker/containerd-shim            ../roles/docker/files/containerd-shim
    mv -f docker/ctr                        ../roles/docker/files/ctr
    mv -f docker/runc                       ../roles/docker/files/runc
fi

${ECHO_CMD} "\n----Download k8s binary:"
${WGET_CMD} https://dl.k8s.io/${K8S_VER}/kubernetes-server-linux-amd64.tar.gz

${ECHO_CMD} "\nPrepare kubernetes binary...."
if [[ -f "kubernetes-server-linux-amd64.tar.gz" ]]; then
  ${ECHO_CMD} "\n----extracting kubernetes binaries..."
  tar zxf kubernetes-server-linux-amd64.tar.gz
  mv -f kubernetes/server/bin/kube-apiserver                ../roles/kube-apiserver/files/
  mv -f kubernetes/server/bin/kube-controller-manager       ../roles/kube-controller-manager/files/
  mv -f kubernetes/server/bin/kubectl                       ../roles/base-package/files/
  mv -f kubernetes/server/bin/kubelet                       ../roles/kubelet/files/
  mv -f kubernetes/server/bin/kube-proxy                    ../roles/kube-proxy/files/
  mv -f kubernetes/server/bin/kube-scheduler                ../roles/kube-scheduler/files/
  mv -f kubernetes/server/bin/apiextensions-apiserver       ../roles/kube-apiserver/files/
fi

${ECHO_CMD} "\n----Download etcd binary:"
${WGET_CMD} https://storage.googleapis.com/etcd/${ETCD_VER}/etcd-${ETCD_VER}-linux-amd64.tar.gz

${ECHO_CMD} "\nPrepare etcd binary..."
if [[ -f "etcd-${ETCD_VER}-linux-amd64.tar.gz" ]]; then
  ${ECHO_CMD} "\n----extracting etcd binaries..."
  tar zxf etcd-${ETCD_VER}-linux-amd64.tar.gz
  mv -f etcd-${ETCD_VER}-linux-amd64/etcd*      ../roles/etcd/files/
else
  ${ECHO_CMD} "Please Download etcd-${ETCD_VER}-linux-amd64.tar.gz Firstly"
fi

${ECHO_CMD} "\n----Download cni plugins:"
${WGET_CMD} https://github.com/containernetworking/plugins/releases/download/${CNI_VER}/cni-plugins-linux-amd64-${CNI_VER}.tgz

${ECHO_CMD} "\nPreprae cni plugion binray..."
if [[ -f "cni-plugins-linux-amd64-${CNI_VER}.tgz" ]]; then
  ${ECHO_CMD} "\n---extracting cni plugins binaries..."
  tar zxf cni-plugins-linux-amd64-${CNI_VER}.tgz -C ../roles/kubelet/files/
else
  ${ECHO_CMD} "Please download cni-${CNI_VER}.tgz Firstly"
fi


${ECHO_CMD} "\n----Download helm:"
${WGET_CMD} https://get.helm.sh/helm-${HELM}-linux-amd64.tar.gz

if [[ -f "helm-${HELM}-linux-amd64.tar.gz" ]]; then
  ${ECHO_CMD} "\n----extracting helm binaries..."
  tar xvf helm-${HELM}-linux-amd64.tar.gz -C ../roles/helm/files/ --strip-components=1 linux-amd64/helm
fi

${ECHO_CMD} "\n----Download calicoctl:"
${WGET_CMD} https://github.com/projectcalico/calicoctl/releases/download/${CALICOCTL}/calicoctl
cp -rf calicoctl ../roles/calico/files/calicoctl


find . -not -name 'download.sh' -delete