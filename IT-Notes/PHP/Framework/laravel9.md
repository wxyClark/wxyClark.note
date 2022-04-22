# laravel9探索

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
.env 文件配置 DB_HOST 当前用到的mysql容器名称
关闭本地 mysql服务(如：xampp、phpStudy)
# 启动容器
./vendor/bin/sail up -d

# 配置本地host mysql容器指向本地
127.0.0.1   laravel_mysql_1

# 初始化数据库
php artisan migrate
```

## WSL2+Docker环境二

启动docker,设置默认WSL2

进入WSL2

```sh
# laravel9 是可以自定义的目录名
curl -s "https://laravel.build/laravel9?with=mysql,redis&devcontainer" | bash

./vendor/bin/sail up -d

composer require laravel/breeze --dev

# 设置host 
127.0.0.1   laravel9_mysql_1

php artisan migrate
```
## 组件
```sh
# 下载入门套件：breeze 
composer require laravel/breeze --dev

# 安装 breeze
php artisan breeze:install
npm install
npm run dev
php artisan migrate
```