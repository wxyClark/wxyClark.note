# OracleLinux8.5

## 基础环境设置

## 安装最新的PHP8

[如何在 Rocky Linux 上安装最新的 PHP 8？](https://zhuanlan.zhihu.com/p/492075338)

```bash
sudo dnf update && sudo dnf upgrade -y

-- 添加EPEL和Remi存储库,这些 repos 是安装PHP 8当前和未来版本的桥梁
sudo dnf install epel-release -y
sudo dnf install -y https://rpms.remirepo.net/enterprise/remi-release-8.rpm

sudo dnf remove php* -y
--  识别EPEL和Remi存储库的添加
sudo dnf update && sudo dnf upgrade -y

-- 检查可安装的PHP版本的可用性
sudo dnf module list php

-- 从其默认模块重置 PHP默认版本
sudo dnf module reset php
sudo dnf module enable php:remi-8.1  

--  安装PHP的默认版本
sudo dnf install php -y

-- 要安装其他 PHP 扩展,请使用以下语法
sudo dnf install php-extension_name 
如
sudo dnf install php-mysqlnd
```