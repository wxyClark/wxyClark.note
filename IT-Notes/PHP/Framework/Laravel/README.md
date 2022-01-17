---
sort: 1
---

# Laravel

laravel框架的核心就是个Ioc容器即服务容器



## 设计模式

### Facade 门面模式

[Facade 门面模式](./0-how.md#Facade门面) 

相对于其他方法来说，最大的特点就是简洁

### 观察者模式 Event-Listener


{% include list.liquid all=true %}

## 避坑
### toArray()

get() 、 pluck() 的结果集，在->toArray() 之前应先判空
* 非空才使用->toArray()，
* 否则返回 []
