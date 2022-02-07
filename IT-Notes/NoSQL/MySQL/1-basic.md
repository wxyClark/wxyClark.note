---
sort: 1
---

# MySQL基础


| 种类    | 完整名称  | 解释 | 解释 | 使用者 |
| ---- | ---- |---- |---- |---- |
| DCL |  Data Control Language | 数据库【控制】语言 | 权限分配、回收 | DBA |
| DDL |  Data Definition Language | 数据库【定义】语言 | 建表、改结构、索引 <br> create、drop、alter | DBA、开发者 |
| DML |  Data Manipulation Language | 数据库【操作】语言 | 增、删、改 <br> insert 、update、delete | 开发者 |
| DQL |  Data Query Language | 数据库【查询】语言 | 查 <br>	select | 开发者 |
| TCL |  Transaction Control Language | 【事务】控制语⾔ | set autocommit=0 <br> start transaction <br> savepoint <br> commit <br >rollback | 开发者 |

## 版本差异

## 概念

### 主键
### 外键

    推荐逻辑外键

## 范式

## 存储引擎

## 字段规则
最小原则

## 索引
### 唯一索引
### 联合索引
最左匹配
### 普通索引

## 事务

## join

* innerJoin on条件字段 为null的数据为过滤掉
* leftJoin on条件右表数据为null的数据不回过滤

