---
sort: 8
---

# query查询过程

## 总流程图
```mermaid
graph TB

    C1==客户端/服务器<br>通信协议==> S1
    RS==返回数据==>C1

    S9--API查询接口-->E

    E--返回数据-->C{是否开启缓存}

    C-->M(是<br>生成缓存)-->S2
    C--否,返回-->RS
    M-->RS
    

    subgraph 客户端

        C1((请求))

    end

    subgraph MySql Server

        S1{连接器<br><br>身份认证<br>权限判断}-->S2[查询缓存]

        S2--命中-->RS>结果集 / 影响行数]
        S2-.->S21(大小写敏感的哈希表)-->S211(show variables like 'query_cache%')
        S2--未命中-->S3[解析器]
        S3--语法解析-->S4>解析树]

        S4-->S5[预处理器]-->S6>新解析树]

        S6-->S7[基于成本的查询优化器]
        S7-.->S71(优化策略)
        S71-->S711[静态优化<br>编译时优化]-->S7111(直接对解析树进行分析<br>并完成优化)
        S7111-.->S71111(将where条件转换成另一种等价形式<br> 一次优化永久有效,常数变化不受影响)

        S71-->S712[动态优化<br>运行时优化]-->S7121(和查询的上下文有关<br>也可能和很多其他因素有关)
        S7121-.->S71211(如where条件中的取值<br>索引中条目对应的数据行数<br>需要每次查询的时候重新评估)


        S7-.->S72(优化类型)-->S721((请看下图))

        S7-->S8>执行计划]

        S8-->S9[查询执行引擎]

    end

    subgraph 存储引擎
        E[存储引擎]
        E -.-> E1[InnoDB]
        E -.-> E2[MyISAM]
        E -.-> E3[...]

        E1--> D1((数据))
        E2--> D1
        E3--> D1
    end

    style S1 stroke:#F00,stroke-width:4px;   
    style S7 stroke:#F00,stroke-width:4px;  
    style RS stroke:#F00,stroke-width:4px;

    style S721 stroke:#30F,stroke-width:4px;  

    style S711 stroke:#30F,stroke-width:2px;  
    style S712 stroke:#30F,stroke-width:2px;  

    style C1 fill:#2ff,fill-opacity:0.1,stroke:#faa,stroke-width:4px
    style S21 stroke:#000,stroke-width:4px;
```
### 优化类型
```mermaid
graph LR
    S72(优化类型)
            S72-->S721[重新定义关联表的顺序]-.->S7211(和SQL编写顺序未必一致)
            S72-->S722[将外连接转化成内连接]-.->S7221(MySQL会重写等价的内连接)
            S72-->S723[使用等价变换规则]-.->S7231(NOT条件转换,恒等 恒不等判定)-->S72311>EXISTS比NOT高效]
            S72-->S725[预估并转化为常数表达式]-.->S7251>不在MySQL中做数据计算]
            S72-->S726[覆盖索引扫描]-.->S7261(索引的叶子存了PK值,无需查询对应的数据行)
            S72-->S727[子查询优化]-.->S7271(转换成一种效率更高的形式)-->S72711>IN常量列表比子查询高效]
            S72-->S728[提前终止查询]-.->S7281>使用limit]
            S72-->S729[等值传播]
            S72-->S72X[列表in的比较]
            S72X-.->S72X1(MySQL将in列表中的数据先进行排序)
            S72X-.->S72X2(然后通过二分查找的方式来确定列表中的值是否满足条件<br>复杂度为logN)-->S72X21>MySQL中in比or高效]
            S72X-.->S72X3(而等价转换成or的查询的复杂度为N)
            S72-->S724[优化count min max]-.->S7241(索引和列是否为空通常可以帮助MySQL优化这类表达式)-->S72411((请看下图))

            style S72311 stroke:#F00,stroke-width:4px;
            style S7251 stroke:#F00,stroke-width:4px;
            style S72411 stroke:#30F,stroke-width:4px;  
            style S72711 stroke:#F00,stroke-width:4px;  
            style S7281 stroke:#F00,stroke-width:4px;  
            style S72X21 stroke:#F00,stroke-width:4px;
```
### count()、max()、min() 优化
```mermaid
graph TB
S724[优化count min max]-.->S7241(索引和列是否为空通常可以帮助MySQL优化这类表达式)
S7241-->S72411[最小值,只需要查询对应B-tree索引最左端的记录--1行数据]
S72411-->S724111(explain中就可以看到 select tables optimized away)
S724111-->S7241111(表示优化器已经从执行计划中移除了该表,并以一个常数取而代之)

S7241-->S72412[count*,通常也可以使用存储引擎提供的一些优]
S72412-->S724121(MyISAM维护了一个变量来存放数据表的行数)
```

## Explain 查询分析器

### 概念

### 列-注释

range
触发条件：只有在使用主键、单个字段的辅助索引、多个字段的辅助索引的最后一个字段进行范围查询才是 range

## 缓存参数设置

| 参数 | 用途 | 备注  |
| ----- | ------ | ------- |
| query_cache_limit | MySQL能够缓存的最大结果 | 如果超出,则增加 Qcache_not_cached的值,并删除查询结果 |
| query_cache_min_res_unit  | 分配内存块时的最小单位大小  |  |
| query_cache_size | 缓存使用的总内存空间大小,单位是字节 | 必须是1024的整数倍，否则实际分配和配置值不同 |
| query_cache_type | 是否打开缓存 | OFF: 关闭 ON: 总是打开  |
| query_cache_wlock_invalidate | 如果某个数据表被锁住,是否仍然从缓存中返回数据 | 默认是OFF,表示仍然可以返回 |

## 联表

* 内连接分为3种：
  
    FROM a INNER JOIN b 
    FROM a JOIN b 
    FROM a b

* inner Join on 条件字段为 null 的数据**会过滤掉**


* 外连接分为2种：

    左外链接：FROM 主表 LEFT JOIN b JOIN 从表
    右外连接：FROM 从表 RIGHT JOIN b JOIN 主表

* left Join on 条件从表数据为 null 的数据**不会过滤**

 ## 子查询  

```tip
⼀般来说，能⽤ exists 的⼦查询，绝对都能⽤ in 代替，所以 exists ⽤的少。推荐使用 in

【大坑】not	in 的情况下，⼦查询中列的值为 NULL 的时候，外查询的结果为空。
```

⼦查询的执⾏优先于主查询执⾏，因为主查询的条件⽤到了⼦查询的结果。

| 名称      | 结果集              | 用于                               | 用法                                                                                                      |
| --------- | ------------------- | ---------------------------------- | --------------------------------------------------------------------------------------------------------- |
| 标量⼦查询 | ⼀⾏⼀列               | select后⾯ <br> where或having后⾯    | >、<、>=、<=、=、<>、!=、in、not in                                                                       |
| 列⼦查询   | ⼀列多⾏              | where或having后⾯                   | in、not in、any、some、all <br> a>some(10,20,30) 大于任意一个值 <br> a>min(10,20,30) <br> a>max(10,20,30) |
| ⾏⼦查询    | ⼀⾏多列              | where或having后⾯                   | in、not in、any、some、all <br> a>some(10,20,30) 大于任意一个值 <br> a>min(10,20,30) <br> a>max(10,20,30) |
| 表⼦查询   | 多⾏多列<br>一行多列 | from后⾯(必须起别名) <br> <br> exists(相关⼦查询)后⾯ | 各种 join <br> <br> 完整的查询语句，返回 1 或 0 |

⾏⼦查询（⼦查询结果集⼀⾏多列）
```sql
--  ⽅式1
SELECT *
FROM employees a
WHERE a.employee_id = (SELECT min(employee_id) FROM employees)
    AND a.salary = (SELECT max(salary) FROM employees);

--  ⽅式2
SELECT *
FROM employees a
WHERE (a.employee_id, a.salary) = 
    (SELECT min(employee_id), max(salary) FROM employees)

--  ⽅式3
SELECT *
FROM employees a
WHERE (a.employee_id, a.salary) in 
    (SELECT min(employee_id), max(salary) FROM employees);
```
