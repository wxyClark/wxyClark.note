---
sort: 0
---

# 运行原理

入口文件 ./public/index.php

```php
# composer自动加载
require __DIR__.'/../vendor/autoload.php';

# 获取laravel核心的Ioc容器
$app = require_once __DIR__.'/../bootstrap/app.php';

# "make"出Http请求的内核
$kernel = $app->make(Illuminate\Contracts\Http\Kernel::class);

# laravel里面所有功能服务的注册加载，乃至Http请求的构造
$response = $kernel->handle(
    $request = Illuminate\Http\Request::capture()
);

# 发送请求
$response->send();

# 执行,返回
$kernel->terminate($request, $response);
```

## Composer自动加载

* 类的自动加载(autoload)机制 解决手动 require/include 造成的遗漏、包含不必要文件的问题。
* Lazy loading (延迟加载) ：在使用类时才自动包含类文件，而不是一开始就将所有的类文件
* PHP 自动加载函数 __autoload()

```
bool  spl_autoload_register ( [callback $autoload_function] )    
接受两个参数：一个是添加到自动加载栈的函数，另外一个是加载器不能找到这个类时是否抛出异常的标志。
第一个参数是可选的，并且默认指向spl_autoload()函数，
这个函数会自动在路径中查找具有小写类名和.php扩展或者.ini扩展名，或者任何注册到spl_autoload_extensions()函数中的其它扩展名的文件。
```

## IOC容器

Laravel 服务容器是一个用于管理类依赖和执行依赖注入的强大工具。

* 服务容器就是工厂模式的升级版，工厂解耦了对象和外部资源之间的关系，但是和外部资源之间存在在耦和
* 服务容器在为对象创建了外部资源的同时，又与外部资源没有任何关系，这个就是 Ioc 容器
* 只要不是由内部生产（比如初始化、构造函数 __construct 中通过工厂方法、自行手动 new 的），而是由外部以参数或其他形式注入的，都属于【依赖注入（DI）】

```html
【依赖注入】是从【应用程序的角度】在描述：应用程序依赖容器创建并注入它所需要的外部资源；
【控制反转】是从【容器的角度】在描述，：容器控制应用程序，由容器反向的向应用程序注入应用程序所需要的外部资源。
```

## Facade门面

门面相对于其他方法来说，最大的特点就是简洁

* Laravel 自带了很多 facades ，几乎可以用来访问到 Laravel 中所有的服务。
* Laravel facades 实际上是服务容器中那些底层类的「静态代理」，相比于传统的静态方法， facades 在提供了简洁且丰富的语法同时，还带来了更好的可测试性和扩展性。

```php
App::make('router')->get('/path', 'PathController@actionName');
使用门面模式方式：
Route::get('/path', 'PathController@actionName')
门面最后调用的函数也是服务容器的make函数
```

当 门面没有指定静态函数时，PHP就会调用魔术函数__callStatic

```php
abstract class Facade
{
    public static function getFacadeRoot()
    {
        return static::resolveFacadeInstance(static::getFacadeAccessor());
    }

    protected static function resolveFacadeInstance($name)
    {
        if (is_object($name)) {
            return $name;
        }

        if (isset(static::$resolvedInstance[$name])) {
            return static::$resolvedInstance[$name];
        }

        # 门面最后调用的函数也是服务容器的make函数
        return static::$resolvedInstance[$name] = static::$app[$name];
    }

    public static function __callStatic($method, $args)
    {
        $instance = static::getFacadeRoot();

        if (! $instance) {
            throw new RuntimeException('A facade root has not been set.');
        }

        return $instance->$method(...$args);
    }   
}
```

每个门面类也就是重定义一下getFacadeAccessor函数

```php
class DB extends Facade
{
    /**
     * Get the registered name of the component.
     *
     * @return string
     */
    protected static function getFacadeAccessor()
    {
        return 'db';
    }
}
```