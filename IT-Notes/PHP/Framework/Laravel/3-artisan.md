---
sort: 2
---

# artisan 命令
查看所有可用的 Artisan 命令的列表
```angular2html
php artisan list
```
查看 命令帮助
```angular2html
php artisan help COMMAND
```
## 加密key
生成 .env 文件 APP_KEY 的值
```angular2html
php artisan key:generate
```

## 生成命令
```angular2html
php artisan make:command
```
- 应先填写类的 signature(命令) 和 description(描述) 属性，这会在使用 list 命令的时候显示出来
- 执行命令时会调用 handle 方法

## 数据库迁移migrate
```angular2html
php artisan migrate:
```

## 缓存

## 队列

## 路由