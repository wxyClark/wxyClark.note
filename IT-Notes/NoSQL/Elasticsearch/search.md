---
sort: 4
---

# 搜索

```tip
Es 模糊查询， 分词的用match； 

短语的用match_phrase；

查询任意的，用wildcard通配符，注意查询的内容是否分词，分词的添加keyword，查询非空的情况，用*。

Wildcard 性能会比较慢。如果非必要，尽量避免在开头加通配符 ? 或者 *，这样会明显降低查询性能
```

```json
{
    "wildcard": {
        "form_name.keyword": "*very*"
    }
}
```

> 如果查询的内容非空，怎么处理？ 直接用*
```json
{
    "wildcard": {
        "form_name": "*"
    }
}
```

## 结构化查询 Query DSL

* 空查询
> GET /_search
```json
{
    "query": {
        "match_all": {}
    }
}
```
* 查询子句
> 一个查询子句一般使用这种结构：
```json
{
    QUERY_NAME: {
        FIELD_NAME: {
            ARGUMENT: VALUE,
            ARGUMENT: VALUE,...
        }
    }
}
```
> 举例 GET /_search
```json
{
    "query": {
        "match": {
            "tweet": "elasticsearch"
        }
    }
}
```

* 合并多子句
> 叶子子句(leaf clauses)(比如match子句)用以在将查询字符串与一个字段(或多字段)进行比较

> 复合子句(compound)用以合并其他的子句,bool: must, must_not, should

> 复合子句可以相互嵌套
```json
{
    "bool": {
        "must": { "match":      { "email": "business opportunity" }},
        "should": [
            { "match":         { "starred": true }},
            { 
                "bool": {
                    "must":      { "folder": "inbox" },
                    "must_not":  { "spam": true }
                }
            }
        ],
        "minimum_should_match": 1
    }
}
```

## 想知道语句非法的具体错误信息，需要加上 explain 参数
> GET /index_name/type_name/query?explain
```json
{
   "query": {
      "tweet" : {
         "match" : "really powerful"
      }
   }
}
```
> 语句错误的详情 "error"
> 
> 语句正确的解释 "explanation"

## 最重要的查询过滤语句 filter & query

* 询语句可以包含过滤子句，反之亦然
* 复合查询语句可以加入其他查询子句，复合过滤语句也可以加入其他过滤子句。
> GET /_search
```json
{
    "query": {
        "filtered": {
            "filter":   {
                "bool": {
                    "must":     { "term":  { "folder": "inbox" }},
                        "must_not": {
                            "query": {
                            "match": { "email": "urgent business proposal" }
                        }
                    }
                }
            }
        }
    }
}
```

| 关键词 | 用途 | 举例 |
| ---- | ---- | ---- |
| term过滤 | **精确匹配** | 比如数字，日期，布尔值<br>或 not_analyzed的字符串(未经分析的文本数据类型) |
| terms过滤 | **精确匹配** <br>允许指定多个匹配条件 | 同上 | 
|  |  |  |
| range过滤 | 按照指定范围**过滤** |范围操作符包含：<br> gt 大于 <br> gte 大于等于 <br> lt 小于等于 <br> lte 小于等于|
|  |  |  | 
| exists过滤 | 包含指定字段 | 只是针对已经查出一批数据来，但是想区分出某个字段是否存在的时候使用 | 
| missing过滤 | **不**包含指定字段 | 同上 |
|  |  |  |
| bool过滤 | 用来合并多个过滤条件 | 操作符：<br> must: 多个查询条件的完全匹配,相当于 and <br> must_not: 多个查询条件的相反匹配，相当于 not <br> should: 至少有一个查询条件匹配, 相当于 or | 
|  |  |  |
| bool 查询| 合并多个查询子句 | 操作符：<br> must: 查询指定文档一定要被包含 <br> must_not: 查询指定文档一定不要被包含 <br> should: 查询指定文档，有则可以为文档相关性加分 |
|  |  |  |
| match_all查询 | 查询到所有文档 | 是没有查询条件下的默认语句 | 
| match查询 | 查询是一个标准查询 | 不管你需要全文本查询还是精确查询基本上都要用到它 |
| multi_match查询 | 查询允许你做match查询的基础上同时搜索多个字段 | C |


```json
{
  
    "term": { 
      "age":26
    },

    "terms": {
        "tag": [ "search", "full_text", "nosql" ]
    },

    "range": {
        "age": {
              "gte":  20,
              "lt":   30
        }
    },

    "exists":   {
        "field":    "title"
    }

    "bool": {
        "must":     { "term": { "folder": "inbox" }},
        "must_not": { "term": { "tag":    "spam"  }},
        "should": [
                    { "term": { "starred": true   }},
                    { "term": { "unread":  true   }}
        ]
    },

    "match": {
      "tweet": "About Search"
    },
    
    "multi_match": {
        "query":    "full text search",
        "fields":   [ "title", "body" ]
    }
}
```

> 以下查询将会找到 title 字段中包含 “how to make millions”，并且 “tag” 字段没有被标为 spam。
如果有标识为 “starred” 或者发布日期为2014年之前，那么这些匹配的文档将比同类网站等级高：
```json
{
  "bool": {
    "must":     { "match": { "title": "how to make millions" }},
    "must_not": { "match": { "tag":   "spam" }},
    "should": [
      { "match": { "tag": "starred" }},
      { "range": { "date": { "gte": "2014-01-01" }}}
    ]
  }
}
```
