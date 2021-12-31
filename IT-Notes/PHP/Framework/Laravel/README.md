---
sort: 1
---

# Laravel

source: `{{ page.path }}`

{% include list.liquid all=true %}

## 闭坑
### toArray()

get() 、 pluck() 的结果集，在->toArray() 之前应先判空
* 非空才使用->toArray()，
* 否则返回 []