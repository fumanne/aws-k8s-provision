### Install Steps
1.  自行准备好 aws access key 以及secret key 写入 roles/bootstrap/vars/auth.yml 中
也可自行修改common.yml, instances.yml, network.yml 中的配置信息

2.  本机执行 `ansible-playbook playbooks/bootstrap.yml`

    `节点创建完成后, 需要对节点赋予IAM role 权限. 请自行参考aws 文档`
       
3.  到download目录, 执行download.sh(请自行翻墙) 会将k8s相关文件download 至 相关role的files 中.
    k8s 的bainary 文件 以git lfs 方式存储. 自行对仓库安装git lfs 插件

    `cd download; sh download.sh`
      
4. 手动渲染 host.ini 以及 ssh_config (今后会做成自动render) 

    **KUBE_APISERVER 地址 为 手动创建一个classic 的elb 的地址**    
    **侦听器: 443 -> 6443**  
    **Ping目标: TCP:6443**   
    **安全组： 放行443**
              
5. 代码copy 至 deploy机器 并执行
    ansible-playbook -i hosts.ini playbooks/provision.yml  

=============================================================
### 查看各个task tags
`ansible-playbook -i host.ini playbooks/provision.yml --list-tags`

#### 部分小task 可以单独执行playbook 以总的provision.yml为playbook, 自行拼装tag 即可

#### 需要更新kubernetes证书(kubernetes.pem, kubernetes-key.pem, kubernetes.csr):
    ansible-playbook -i host.ini playbooks/provision.yml  -t "kubernetes-ca-init, kubernetes-ca-distribution"
    
#### 需要更新kube-apiserver.service， 其他服务类似:
    ansible-playbook -i host.ini playbook/privision.yml -t "kube-apiserver-prepare,kube-apiserver-unit"
    
#### 清理集群信息
    ansible-playbook -i host.ini playbook/clean.yml    






