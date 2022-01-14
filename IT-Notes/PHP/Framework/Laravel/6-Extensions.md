---
sort: 6
---

# 扩展 Extensions

## maatwebsite/excel

```
composer require "maatwebsite/excel:~3.1.25"
```

* 安装完成后，修改 config/app.php 在 providers 数组内追加如下内容

```
'providers' => [
    ...
    Maatwebsite\Excel\ExcelServiceProvider::class,
],
```

* 同时在 aliases 数组内追加如下内容

 ```
 'aliases' => [
    ...
    'Excel' => Maatwebsite\Excel\Facades\Excel::class,
]
```
* 接下来运行以下命令生成此扩展包的配置文件 config/excel.php：

```
php artisan vendor:publish --provider="Maatwebsite\Excel\ExcelServiceProvider"
```

* 修改 config/excel.php 的 to_ascii 配置

```
    //  to_ascii 默认值为true，会导致excel文件中的中文无法读取
    'to_ascii'                => false,
    //  设置特殊字符白名单
    'slug_whitelist'       => '._（）() */',    //  -
```

### 导入

```
$reader = Excel::load($excelFilePath);

读取第一个sheet
$rowList = $reader->first()->toArray();

读取所有数据
$dataList = $reader->all()->toArray();
```

### 导出
store(指定后缀名)保存到本地 storage/export 目录；export(指定后缀名)导出到页面

```
Excel::create(time(), function ($excel) use ($rowList) {
                $excel->sheet('sheet1', function ($sheet) use ($rowList) {
                    $sheet->rows($rowList);
                });
            })->store('xlsx');
```

### 注意事项

导出数据指定key是否有效，Excel导出 按标题顺序对应