---
sort: 0
---

# 运行原理

## Composer自动加载

* 类的自动加载(autoload)机制 解决手动 require/include 造成的遗漏、包含不必要文件的问题。
* Lazy loading (延迟加载) ：在使用类时才自动包含类文件，而不是一开始就将所有的类文件
* PHP 自动加载函数 __autoload()
```
bool  spl_autoload_register ( [callback $autoload_function] )    接受两个参数：一个是添加到自动加载栈的函数，另外一个是加载器不能找到这个类时是否抛出异常的标志。第一个参数是可选的，并且默认指向spl_autoload()函数，这个函数会自动在路径中查找具有小写类名和.php扩展或者.ini扩展名，或者任何注册到spl_autoload_extensions()函数中的其它扩展名的文件。
```

## Facade门面

* 门面相对于其他方法来说，最大的特点就是简洁
* Laravel 自带了很多 facades ，几乎可以用来访问到 Laravel 中所有的服务。
* Laravel facades 实际上是服务容器中那些底层类的「静态代理」，相比于传统的静态方法， facades 在提供了简洁且丰富的语法同时，还带来了更好的可测试性和扩展性。

```
App::make('router')->get('/path', 'PathController@actionName');
使用门面模式方式：
Route::get('/path', 'PathController@actionName')
门面最后调用的函数也是服务容器的make函数
```

当 门面没有指定静态函数时，PHP就会调用魔术函数__callStatic

```
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

```
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