# laravel9探索

[构建Laravel开发环境](https://learnku.com/docs/laravel-development-environment/9.x/building-the-sail-environment-under-macos/12319)

环境：

* Win11专业版系统
* WSL2 Oracle Linux8.5
* DockerDesktop
* php8
* composer2
* docker 设置默认WSL2


## WSL2+Docker环境一

### 安装

```sh
# 下载源码
git clone https://github.com/laravel/laravel.git

# 安装依赖包
comoser update

# 生成加密串
php artisan key:generate

# 测试
php artisan serve
```

### 初始化

```sh
# 安装sail,自带docker-compose.yml
php artisan sail:install

# 配置容器用户
useradd sail
usermod -a -G sail sail
.env 文件添加 WWWGROUP、WWWUSER配置为1000
.env 文件配置 DB_HOST=laravel_mysql_1 REDIS_HOST=laravel_reids_1
关闭本地 mysql服务(如：xampp、phpStudy)
# 启动容器
./vendor/bin/sail up -d

# 配置本地host mysql容器指向本地
127.0.0.1   

# 初始化数据库
php artisan migrate
```

## WSL2+Docker环境二

启动docker,设置默认WSL2

进入WSL2

```sh
# laravel9 是可以自定义的目录名
curl -s "https://laravel.build/laravel9?with=mysql,redis&devcontainer" | bash

cd laravel9  

./vendor/bin/sail up -d

# 设置host 
127.0.0.1   laravel9_mysql_1
127.0.0.1   laravel9_reids_1

# .env 文件配置 
DB_HOST=laravel_mysql_1 
REDIS_HOST=laravel9_reids_1
```
## 组件

### breeze

```sh
# 下载
composer require laravel/breeze --dev
php artisan breeze:install

# 安装 nodejs 有版本要求 >12.14
yum remove npm
curl -sL https://rpm.nodesource.com/setup_12.x | bash -
# curl -sL https://deb.nodesource.com/setup_15.x | bash - 
yum install nodejs

# 修改 package-lock.json, 删除 fsevents 依赖

# 安装 npm
npm install && npm run dev

php artisan migrate
```

### jetstream
[安装文档](https://jetstream.laravel.com/2.x/installation.html)
```sh
composer require laravel/jetstream

npm install
npm run dev
php artisan migrate

npm run dev
```