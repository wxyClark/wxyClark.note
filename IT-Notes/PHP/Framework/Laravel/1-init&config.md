---
sort: 1
---

# Laravel 安装&配置
Laravel 8.x  PHP对应的版本>=7.3.0
Laravel 7.x  PHP对应的版本>=7.2.5
Laravel 6.x  PHP对应的版本>=7.2.0
Laravel>=5.6 PHP对应的版本>=7.1.3

## 通过 Composer 创建项目  

    composer create-project --prefer-dist laravel/laravel=8.0.* 目标目录

## 本地开发环境
如果本地安装了 PHP 可使用 PHP 内置的服务器来为应用程序提供服务 http://localhost:8000

    php artisan serve

生成应用密钥  

    php artisan key:generate

## Laravel配置
* 将 web 服务器根目录指向 laravel 目标目录/public
* 配置Web 读写权限：storage 目录和 bootstrap/cache，否则 Laravel 程序将无法运行
* config/app.php 配置 timezone、locale、debug

### .env  

```tip
ENV 的加载功能由类 \Illuminate\Foundation\Bootstrap\LoadEnvironmentVariables::class 完成
```

若想要自定义 env 文件，就可以在 bootstrap 文件夹中 app.php 文件

```php
//  定义路径
$app->useEnvironmentPath('/customer/path');
//  定义文件
$app->loadEnvironmentFrom('customer.env');
```

* 将 .env.example 文件重命名为 .env 
* .env 文件中列出的所有变量将被加载到 PHP 的超级全局变量 $_ENV 中,

env变量配置规则
```nginx
key=value
# 注释易 # 开始
# value值 不使用引号包裹时 不允许出现空格
# value值 使用引号包裹时 不允许出现 \, 只能使用转义符号 \\; 不允许出现内嵌 " , 只能使用 \"
```

可以在 env 文件中使用变量为变量赋值

```nginx
NVAR1="Hello"
NVAR2="World!"
NVAR3="{$NVAR1} {$NVAR2}"
```

代码中使用 env 配置的变量, xxkey 不能使用_ENV, value 才可以

```php
$this->assertEquals('xxkey', $_ENV['NVAR3']);
```

### config

* Laravel 框架的所有配置文件都放在 config 目录中
* config目录下使用 env('key', 'defaultValue') 设置默认值
* 代码中使用 App::environment('configKey') 检查 当前的环境配置是否与给定值匹配


```nginx
APP_ENV 也可以直接在 nginx 中配置
fastcgi_param  APP_ENV  production;
```

### 缓存config/cache.php
* laravel默认使用文件缓存file，将序列化的缓存对象存储在文件系统中
* 生成数据库缓存的migration文件
```
php artisan cache:table 
```
* Memcached缓存 需要安装 [Memcached PECL 扩展包](https://pecl.php.net/package/memcached)
* Redis缓存 需要通过 Composer 安装 predis/predis 扩展包 (~1.0)

## Web 服务器配置
### Apache
* 请务必启用 mod_rewrite 模块，让服务器能够支持 .htaccess 的解析
* public/.htaccess 为前端控制器提供了隐藏 index.php
* 如果 Laravel 附带的 .htaccess 文件不起作用，尝试下面的方法替代:

```
    Options +FollowSymLinks
    RewriteEngine On

    RewriteCond %{REQUEST_FILENAME} !-d
    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteRule ^ index.php [L]
```
### Nginx
* 入口文件 index.php

```
    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }
```
## 生产环境优化
### 优化自动加载
确保项目的源代码管理库中包含了 composer.lock

    composer install --optimize-autoloader
### 优化配置加载
这个命令可以将所有 Laravel 的配置文件合并到单个文件中缓存， 此举能大大减少框架在加载配置值时必须执行的系统文件的数量

    php artisan config:cache

