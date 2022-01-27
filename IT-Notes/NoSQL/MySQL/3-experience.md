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


```conf
[mysqld]
log_output='FILE,TABLE';

# 代表开启慢sql参数进行开启
slow_query_log=ON 

# 查询时间（秒）
long_query_time=0.001
```