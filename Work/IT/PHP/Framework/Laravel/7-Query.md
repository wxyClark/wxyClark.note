---
sort: 7
---

# 查询

```tip
单表查询 结果集转数组：return $result ? $result->toArray(): [];

联表查询 结果集转数组：return json_decode(json_encode($result), true);
```

## collect()

同一组数据需要按不同维度聚合，可以一次查询，对结果集再做分组计算

## pluck

支持获取 key => value 数组，也可以只获取 value 数组

```php
$map = $this->model->where($condition)->distinct()->pluck('value'[, 'key']);
//  toArray前判空

return $map ? $map->toArray() : [];
```

二维数组使用pluck

```php
$collection = collect([
    ['product_id' => 'prod-100', 'name' => 'Desk', 'price'=>10.2],
    ['product_id' => 'prod-200', 'name' => 'Chair', 'price'=>10.3],
]);
return $collection->pluck('name', 'product_id');
```

## count

按指定字段唯一值统计数量
```php
    public function getAccountTotalCount($params)
    {
        return $this->baseQuery($params)->count(DB::raw("distinct(account_code)"));
    }
```

## 原生SQL

```php
【*】这是错误的用法
$query->where(DB::raw("(is_reply = 2 OR (is_reply = 1 AND reply_at > '". '2022-5-14 00:00:00' ."'))"));
$query->whereRaw("(is_reply = 2 OR (is_reply = 1 AND reply_at > '". '2022-5-14 00:00:00' ."'))");
```