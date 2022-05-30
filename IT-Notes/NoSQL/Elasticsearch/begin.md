---
sort: 1
---

| 简写 | 全称 | 释意 | 备注 |
| --- | --- | --- | --- |
| JSON | JavaScript Object Notation | Javascript对象符号 | --- |
| DSL | Domain Specific Language | 特定领域语言 | --- |


# 入门

* 天生支持分布式(大量非关键数据的存储首先考虑ES)
* Elasticsearch是一个基于Apache Lucene(TM)的开源搜索引擎。无论在开源还是专有领域，Lucene可以被认为是迄今为止最先进、性能最好的、功能最全的搜索引擎库。
* ELasticsearch使用 **JSON** 作为文档序列化格式
* 在Elasticsearch中存储数据的行为就叫做**索引(indexing)**
  > Relational DB -> Databases -> Tables -> Rows -> Columns   | 索引(index)
  
  > Elasticsearch -> 索引Indices   -> Types  -> Documents -> Fields  | 倒排索引(inverted index)
* 默认情况下，文档中的所有字段都会被索引（拥有一个倒排索引），只有这样他们才是可被搜索的。
* 建立或更新索引    ：PUT /index_name/type_name/ID JSON
* 检查文档是否存在 ：HEAD /index_name/type_name/ID
* 删除文档      ：DELETE /index_name/type_name/ID
* 检索文档         ：GET /index_name/type_name/ID 返回的JSON文档在 _source 字段中
* 搜索全部         ：GET /index_name/type_name/_search
* query查询       ：GET /index_name/type_name/_search?**q=last_name:Smith**
* DSL语句查询      ：GET /index_name/type_name/_search **JSON**
```json
# GET /index_name/type_name/_search
{
    "query" : {
        "match" : {
            "last_name" : "Smith"
        }
    }
}
```  
* 匹配类型：match、过滤器filter、短语查询match_phrase、高亮highlight
* 聚合(aggregations)aggs 类似于SQL的GROUP BY