# Linux

* 关闭SELinux功能，提升系统安全性。
```
查看Selinux状态 getenforce

临时使其关闭的命令 setenforce 0

永久关闭 vim /etc/selinux/config 
SELINUX=enforcing　　//修改此处为disabled

这样在重启前后都可以使SELinux关闭生效
```
* SELinux(Security-Enhanced Linux) 是美国国家安全局（NSA）对于强制访问控制的实现。


{% include list.liquid all=true %}
