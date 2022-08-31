# 1. MySQL


{% include list.liquid all=true %}

<hr />

## 适用场景

## 不适用场景的替代方案


[MySQL数据库企业级核心知识精品](http://edu.51cto.com/course/course_id-4058.html)

[MySQL数据库企业级应用实战](http://edu.51cto.com/pack/view/id-214.html)

[percona博客](https://www.percona.com/blog/)

[O'Reilly高性能MySQL 代码示例](http://www.highperfmysql.com)

[MySQL架构](https://baijiahao.baidu.com/s?id=1710034614164958724&wfr=spider&for=pc)

## 集群

用途：可伸缩性（Scalability）、高可用性（Availability）

简单地说，集群就是指一组（若干个）相互独立的计算机，利用高速通信网络组成的一个较大的计算机服务系统，每个集群节点（即集群中的每台计算机）都是运行各自服务的独立服务器。这些服务器之间可以彼此通信，协同向用户提供应用程序、系统资源和数据，并以单一系统的模式加以管理。当用户客户机请求集群系统时，集群给用户的感觉就是一个单一独立的服务器，而实际上用户请求的是一组集群服务器。

## 架构

![MySQL架构图](../../../img/NoSQL/MySQL-Structure.png)

不同的存储引擎保存数据和索引的方式是不同的；但表的定义则是在MySQL服务层统一处理的。
事务的实现在存储引擎层，所有事务部支持多种引擎的表；LOCK TABLES、UNLOCK TABLES、ALTER TABLE在MySQL服务层处理，与引擎无关


## 主从问题

* 刚向主库写数据，立即向从库读取数据可能读取不到刚创建的数据，主从同步需要时间
> 需要用到刚入库的数据时，应直接取用入库的数据值，不走读取，使用事务保证原子性


## 性能

* EXPLAIN query 查看索引情况
* 在MySQL 5.6 及之后的版本中，我们可以使用 optimizer trace 功能查看优化器生成执行计划的整个过程
```sql
SET optimizer_trace="enabled=on";        // 打开 optimizer_trace
SELECT * FROM order_info where uid = 5837661 order by id asc limit 1
SELECT * FROM information_schema.OPTIMIZER_TRACE;    // 查看执行计划表
SET optimizer_trace="enabled=off"; // 关闭 optimizer_trace
```