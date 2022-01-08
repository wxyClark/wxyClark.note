# CentOS

当前推荐系统版本 CentOS7

## 系统安装

[镜像站列表](http://isoredirect.centos.org/centos/7/isos/x86_64/)

* 推荐镜像 CentOS-7-x86_64-Minimal-2009.iso

* 查看包组列表
```
yum grouplist
```
* 必装软件包 
```
指定包组名安装，注意要带双引号
yum groupinstall "Compatibility libraries" "Base" "Development tools"
yum groupinstall "debugging Tools" "Dial-up Networking Support"

```

* 更换国内源

* 初次安装系统，建议更新。运行中的系统不建议更新
```
yum upgrade-y
```

## 系统配置

* 手工指定DNS
* 激活网卡
```
ONBOOT=no 设置为yes，激活网卡
```
* 重启网卡

    尽量不要使用/etc/init.d/network restart重启网卡，因为这条命令会影响所有的网卡
    
    推荐制定网卡方式重启
    ```
    ifdown eht0 && ifup eth0
    ```
* 设定运行级别为3(文本模式),需要重启
```
# Default runlevel. The runlevels used are:
#   0 - halt (Do NOT set initdefault to this)
#   1 - Single user mode
#   2 - Multiuser, without NFS (The same as 3, if you do not have networking)
#   3 - Full multiuser mode  命令行多用户模式
#   4 - unused
#   5 - X11   图形界面模式 临时切换 startx
#   6 - reboot (Do NOT set initdefault to this)

vim /etc/inittab
id:3:initdefault:  
```   