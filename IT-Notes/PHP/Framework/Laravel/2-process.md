---
sort: 2
---

# 工作原理

## 自动注入
把有依赖关系的类放到容器中，解析出这些类的实例，就是依赖注入。目的是实现类的解耦。
- Controller 使用的 Request、Service 依赖注入
```angular2html
public function abc(AbcRequest $request, DefService $service) 
{
    try {
        return $service->doSth($request->all());
    } catch (Exception $e) {
        //  处理
    } catch (Throwable $t) {
        //  处理
    }
}
```  
- Service 使用的 Repository 依赖注入 
```angular2html
public function doSth(Repository $repository)
{
    DB::beginTransaction();
    try {
        $repository->doA();

        $repository->doB();

        DB::commit();

        return [统一格式];
    } catch (Exception $e) {
        DB::rollback();
        //  处理
        return [统一格式];
    } catch (Throwable $t) {
        DB::rollback();
        //  处理
        return [统一格式];
    }
}
```
- Repository 使用的 Model 依赖注入 
```angular2html
public function querySth(XxxModel $model)
{
    $list = $model->all();
    $list = $model->pluck();

    if (empty($list)) {
        return [];
    }
    
    return $list->toArray();
}
```

    
    你可以简单地使用「类型提示」的方式在由容器解析的类的构造函数中添加依赖项，
    包括 控制器、监听事件、队列任务、中间件 等。
    事实上，这是你的大多数对象也应该由容器解析。
```angular2html
/**
 * UserRepository 的实例对象
 */
protected $users;

//  依赖注入
public function __construct(UserRepository $users)
{
    $this->users = $users;
}
```