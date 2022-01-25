# 常用SQL

## 建表

## 修改表

```sql
--  添加索引
ALTER TABLE `table_name` ADD PRIMARY KEY |UNIQUE  (`column1`, `column2`, `column3`);
ALTER TABLE `table_name` ADD INDEX  index_name (`column1`, `column2`, `column3`);
```