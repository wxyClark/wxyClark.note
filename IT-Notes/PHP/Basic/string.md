# 字符串

## json

```php
//  JSON_UNESCAPED_UNICODE（中文不转为unicode ，对应的数字 256）
//  JSON_UNESCAPED_SLASHES （不转义反斜杠，对应的数字 64）)
json_encode($array, JSON_UNESCAPED_SLASHES|JSON_UNESCAPED_UNICODE);
```
