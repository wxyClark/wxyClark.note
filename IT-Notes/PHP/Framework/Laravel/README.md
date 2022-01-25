---
sort: 1
---

{% include list.liquid all=true %}

<hr />

# Laravel

laravel框架的核心就是个Ioc容器即服务容器



## 设计模式



### Facade门面模式

[Facade 门面模式](./0-how.md#Facade门面) 

相对于其他方法来说，最大的特点就是简洁

如： Route、DB

### 单例模式

./bootstrap/app.php

```
$app->singleton(
    Illuminate\Contracts\Http\Kernel::class,
    App\Http\Kernel::class
);

$app->singleton(
    Illuminate\Contracts\Console\Kernel::class,
    App\Console\Kernel::class
);

$app->singleton(
    Illuminate\Contracts\Debug\ExceptionHandler::class,
    App\Exceptions\Handler::class
);
```

### 观察者模式 Event-Listener


## 避坑

### 插件

* 插件安装成功后，须在 config/app.php 中配置 别名
* 多项目须注意 依赖的插件 保持版本统一

### toArray()

get() 、 pluck() 的结果集，在->toArray() 之前应先判空
* 非空才使用->toArray()，
* 否则返回 []

