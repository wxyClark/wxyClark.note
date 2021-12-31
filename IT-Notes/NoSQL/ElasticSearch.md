---
sort: 3
---

# ElasticSearch
[官方文档](https://www.elastic.co/guide/en/elasticsearch/reference/current/getting-started.html)
[官方 中文](https://www.elastic.co/cn/elasticsearch/)
[阮一峰 全文搜索引擎 Elasticsearch 入门教程](http://www.ruanyifeng.com/blog/2017/08/elasticsearch.html)


ES集群对外提供RESTful API

| 版本          | 差异          | date |
| --------------- | -------------- | ---- |
| Elastic 5.x | Lucene 6.x 的支持，磁盘空间少一半；索引时间少一半；查询性能提升25%；支持IPV6       | 2016.10.26 |
| Elastic 6.x          | 开始不支持一个 index 里面存在多个 type。  | 2017.08.31 |
| Elastic 7.x    | 正式废除单个索引下多Type的支持，7.1开始，Security功能免费使用，支持k8s | 2019.04.10 |

## 安装
### 前置条件
Elastic 需要 Java 8 环境。注意要保证环境变量JAVA_HOME正确设置。

### 安装配置
```
$ wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.5.1.zip
$ unzip elasticsearch-5.5.1.zip
$ cd elasticsearch-5.5.1/ 
 ./bin/elasticsearch
```

* Elastic 就会在默认的9200端口运行
```angular2html
curl localhost:9200
```

* 设置远程访问

  Elastic 默认只允许本机访问

  修改 Elastic 安装目录的config/elasticsearch.yml文件

  将它的值改成0.0.0.0（任何人都可以访问，线上不建议），然后重新启动 Elastic。
  
  去掉network.host的注释
```
network.host: 0.0.0.0
```
### 后置条件
ELK是三个开源软件的缩写，分别表示：Elasticsearch , Logstash， Kibana , 它们都是开源软件。

## 基本概念

Elastic 本质上是一个分布式数据库，允许多台服务器协同工作， 每台服务器可以运行多个 Elastic 实例。

<!-- prettier-ignore-start -->
| 概念    | 定义  |
| ------- | -------- |
| 集群(cluster)| 一组节点构成一个集群(cluster) |
| 节点(node)| 一个 Elastic 实例称为一个节点(node) |
| 索引(index)| Elastic 会索引所有字段，经过处理后写入一个 反向索引(Inverted Index)， 用于查询。|
| 文档(document)|  索引(index)里面单条的记录称为 文档(document)|
| 分组(type)|虚拟的逻辑分组，用来过滤文档(document)，不同的 分组(type) 应该有相似的 结构(scheme)|
| 结构(scheme)|元素组成、元素数据类型|
<!-- prettier-ignore-end -->

### 索引 index
* Elastic 数据管理的顶层单位就叫做 Index（索引）。
* 它是单个数据库的同义词。每个 Index （即数据库）的名字必须是小写。
* 同一个 Index 里面的 Document，不要求有相同的结构(scheme)，但是最好保持相同，这样有利于提高搜索效率。

## 操作

| 操作项          | 命令          | 说明 |
| --------------- | -------------- | ---- |
| 新建 Index | curl -X PUT 'localhost:9200/weather'       | 索引名称weather |
| 查看所有 Index          |curl -X GET 'localhost:9200/_cat/indices?v'    | 1984 |
| 列出每个Index所包含的Type | curl 'localhost:9200/_mapping?pretty=true' | 1986 |
| 删除 Index    | curl -X DELETE 'localhost:9200/weather' | 1986 |
| 查询所有  | curl 'localhost:9200/accounts/person/_search' | AND 须使用布尔查询 |
| 查询记录  | curl 'localhost:9200/accounts/person/1?pretty=true' | 以易读的格式返回 |


### 新建 Index
直接向 Elastic 服务器发出 PUT 请求。下面的例子是新建一个名叫weather的 Index
```angular2html
$ curl -X PUT 'localhost:9200/weather'
```
服务器返回一个 JSON 对象，里面的acknowledged字段表示操作成功。


向指定的 /Index/Type 发送 PUT 请求，就可以在 Index 里面新增一条记录

注：accounts/person/1 的1 是该条记录的 Id。它不一定是数字，任意字符串（比如abc）都可以
```angular2html
$ curl -X PUT 'localhost:9200/accounts/person/1' -d '
{
  "user": "张三",
  "title": "工程师",
  "desc": "数据库管理"
}'
```
也可以不指定ID，使用POST新增记录
```angular2html
$ curl -X POST 'localhost:9200/accounts/person' -d '
{
  "user": "李四",
  "title": "工程师",
  "desc": "系统管理"
}'
```
```tip
注意，如果没有先创建 Index，直接执行新增记录的命令，Elastic 也不会报错，而是直接生成指定的 Index。
所以，打字的时候要小心，不要写错 Index 的名称。
```

### 查看 Index

查看当前节点的所有 Index
```angular2html
$ curl -X GET 'http://localhost:9200/_cat/indices?v'
```

列出每个 Index 所包含的 Type
```angular2html
$ curl 'localhost:9200/_mapping?pretty=true'
```

### 删除 Index

发出 DELETE 请求，删除一个 Index
```angular2html
$ curl -X DELETE 'localhost:9200/weather'
```


### 查看记录
发送GET请求。 pretty=true表示以易读的格式返回。如果 Id 不正确，就查不到数据，found字段就是false。
```angular2html
$ curl 'localhost:9200/accounts/person/1?pretty=true'
```

### 更新记录
使用 PUT 请求，重新发送一次数据。
```angular2html
$ curl -X PUT 'localhost:9200/accounts/person/1' -d '
{
    "user" : "张三",
    "title" : "工程师",
    "desc" : "数据库管理，软件开发"
}'
```

### 删除记录
发送DELETE请求
```angular2html
$ curl -X DELETE 'localhost:9200/accounts/person/1'
```

## 数据查询
### 返回所有记录
使用 GET 方法，直接请求/Index/Type/_search，就会返回所有记录。

返回结果的 took字段表示该操作的耗时（单位为毫秒），timed_out字段表示是否超时;max_score：最高的匹配程度。
```angular2html
$ curl 'localhost:9200/accounts/person/_search'
```

### 全文搜索
Elastic 的查询非常特别，使用自己的查询语法，要求 GET 请求带有数据体。size 默认10 类似limit,from类似offset指定位移
```angular2html
$ curl 'localhost:9200/accounts/person/_search'  -d '
{
    "query" : { "match" : { "desc" : "软件" }},
    "from": 20,
    "size": 20,
}'
```

### 逻辑运算
如果有多个搜索关键字， Elastic 认为它们是or关系。例： 软件 or 系统
```angular2html
$ curl 'localhost:9200/accounts/person/_search'  -d '
{
    "query" : { "match" : { "desc" : "软件 系统" }}
}'
```
如果要执行多个关键词的and搜索，必须使用布尔查询。
```angular2html

$ curl 'localhost:9200/accounts/person/_search'  -d '
{
  "query": {
    "bool": {
      "must": [
        { "match": { "desc": "软件" } },
        { "match": { "desc": "系统" } }
      ]
    }
  }
}'
```

## 中文分词设置
### 安装中文分词插件