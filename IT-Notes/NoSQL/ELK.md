# ELK

E: ElasticSearch

```tip
注意MySQL ES 时区配置是否一致

mysql datetime 数据写入ES 会变成longInt类型 读取时手动格式化 
```

```php
$dateTime = '-';
if (isset($item['esDateTime]) && $item['esDateTime] > 1000) {
    $dateTime = date('Y-m-d H:i:s', $item['esDateTime]);
}
```