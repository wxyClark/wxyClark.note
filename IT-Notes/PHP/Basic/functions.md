# 函数参考

## 影响PHP行为的扩展


[php_sapi_name](https://www.php.net/manual/zh/function.php-sapi-name.php) — 返回 web 服务器和 PHP 之间的接口类型,
```php
# PHP 常量 PHP_SAPI 具有和 php_sapi_name() 相同的值
php_sapi_name(): string|false
# 可能返回的值包括了 apache、 apache2handler、 cgi （直到 PHP 5.3）, cgi-fcgi、cli、 cli-server、 embed、fpm-fcgi、 litespeed、 nsapi、phpdbg。
```

## 异常处理

```tip
set_error_handler() + register_shutdown_function() + error_get_last()
```

[set_exception_handler](https://www.php.net/manual/zh/function.set-exception-handler.php) — 设置用户自定义的异常处理函数

```php
# 设置默认的异常处理程序，用于没有用 try/catch 块来捕获的异常
#  在 exception_handler 调用后异常会中止。
set_exception_handler(callable $exception_handler): callable

# 参数
handler(Throwable $ex): void
# 返回值
# 返回之前定义的异常处理程序的名称，或者在错误时返回 null。 如果未定义异常处理程序，也会返回 null。
```

实例：

```php
function exception_handler($exception) {
  echo "Uncaught exception: " , $exception->getMessage(), "\n";
}

set_exception_handler('exception_handler');

throw new Exception('Uncaught Exception');
echo "Not Executed\n";
```

[rigger_error](https://www.php.net/manual/zh/function.trigger-error.php) — 产生一个用户级别的 error/warning/notice 信息

```php
# error_msg 该 error 的特定错误信息，长度限制在了 1024 个字节。超过 1024 字节的字符都会被截断。
# error_type该 error 所特定的错误类型。仅 E_USER 系列常量对其有效，默认是 E_USER_NOTICE。
trigger_error(string $error_msg, int $error_type = E_USER_NOTICE): bool

# 用于触发一个用户级别的错误条件，它能结合内置的错误处理器所关联，或者可以使用用户定义的函数作为新的错误处理程序(set_error_handler())。
# 该函数在你运行出现异常时，需要产生一个特定的响应时非常有用。
if ($divisor == 0) {
    trigger_error("Cannot divide by zero", E_USER_ERROR);
}
```


[register_shutdown_function](https://www.php.net/manual/zh/function.register-shutdown-function.php) — 注册一个会在php中止时执行的函数

* 当页面被用户强制停止时
* 当程序代码运行超时时
* 当PHP代码执行完成时，代码执行存在异常和错误、警告

```php
# 程序在运行的时候可能存在执行超时，或强制关闭等情况，但这种情况下默认的提示是非常不友好的,此时可用
register_shutdown_function(callable $callback, mixed $parameter = ?, mixed $... = ?): void

```