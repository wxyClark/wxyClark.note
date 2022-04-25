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

## Excel导出数据为0的项展示空白

```php
use PhpOffice\PhpSpreadsheet\Shared\StringHelper;
$number = '一个数值';
$number = StringHelper::formatNumber($number);

```