# 注意细节

## 语法
?? 判定变量是否定义

```php
$a ?? 0; <=> isset($a) ? $a : 0; 

//  当需要对$a 做运算时
$array[$key] = 0;
if (isset($array[$key])) {
    $array[$key] = $array[$key] * $rate;
}
```

## 转义

## 隐式类型转换