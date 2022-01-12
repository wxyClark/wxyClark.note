---
sort: 7
---

# 查询

## pluck

支持获取 key => value 数组，也可以只获取 value 数组
```
$map = $this->model->where($condition)->pluck('value'[, 'key']);
//  toArray前判空
if ($map) {
    return $map->toArray();
}

return [];
```

二维数组使用pluck
```
$collection = collect([
    ['product_id' => 'prod-100', 'name' => 'Desk', 'price'=>10.2],
    ['product_id' => 'prod-200', 'name' => 'Chair', 'price'=>10.3],
]);
return $collection->pluck('name', 'product_id');
```