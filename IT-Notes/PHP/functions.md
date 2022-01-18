# 函数参考

## 影响PHP行为的扩展


[php_sapi_name](https://www.php.net/manual/zh/function.php-sapi-name.php) — 返回 web 服务器和 PHP 之间的接口类型,
```php
# PHP 常量 PHP_SAPI 具有和 php_sapi_name() 相同的值
php_sapi_name(): string|false
# 可能返回的值包括了 apache、 apache2handler、 cgi （直到 PHP 5.3）, cgi-fcgi、cli、 cli-server、 embed、fpm-fcgi、 litespeed、 nsapi、phpdbg。
```
