# 小技巧

## 单项目调试

php artisan serve

## 打印原生SQL

```php
DB::connection()->enableQueryLog();
DB::table('students')->select('id','name','age')->get();
$log = DB::getQueryLog();
dd($log);
```