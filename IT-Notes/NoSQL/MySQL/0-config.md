# 配置

## 权限配置

* 程序使用的数据库账号不能使用super
* 对于程序连接数据库账号，遵循权限最小原则，不越权，不跨库

## 参数配置

* 启用慢查询日志
```
# 设置日志文件
set global slow_query_log_file = /PATH/slow_mysql.log  
# 记录未使用索引的sql查询
set global log_queries_not_using_indexes = on  
# 慢查询判定标准，1秒以上
set global long_query_time = 1   
```
* 分析慢查询日志
```
mysqldumpslow slow-mysql.log
```


## 备份&恢复