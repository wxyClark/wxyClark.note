---
sort: 3
---

# 实战经验

## 优化思路


## 锁

### 隔离级别

### 怎样实现死锁
#### 原理

### 怎样解决死锁
#### 查看死锁

### 怎样避免死锁

## 查询优化

### 发现问题：慢查询日志

* 开启慢查询日志配置
  
```conf
[mysqld]
log_output='FILE,TABLE';

# 代表开启慢sql参数进行开启
slow_query_log=ON 

# 查询时间（秒）
long_query_time=0.001
```

* 重启服务生效
  
```cs
service mysqld restart
```

* 修改全局服务配置——不需要重启就可以生效

```cs
set global log_output='TABLE,FILE';
set global slow_query_log = 'NO';
set long_query_time = 0.001;
```

#### 配置参数

当log_output设置为TABLE的时候，就会将mysql的慢查询日志记录到mysql.slow_log表中去
