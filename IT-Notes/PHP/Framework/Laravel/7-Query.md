---
sort: 7
---

# 查询

## pluck

支持获取 key => value 数组，也可以只获取 value 数组

```php
$map = $this->model->where($condition)->distinct()->pluck('value'[, 'key']);
//  toArray前判空
if ($map) {
    return $map->toArray();
}

return [];
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