---
sort: 1
---

# Laravel

## 设计模式
### Facade 门面模式

### 观察者模式 Event-Listener


{% include list.liquid all=true %}

## 闭坑
### toArray()

get() 、 pluck() 的结果集，在->toArray() 之前应先判空
* 非空才使用->toArray()，
* 否则返回 []
