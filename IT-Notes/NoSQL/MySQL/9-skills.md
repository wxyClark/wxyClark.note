# 奇技淫巧

# CASE WHEN...THEN

```sql
SELECT id, 
    CASE
        WHEN cast(`status` AS SIGNED) < 45 
            THEN '1' 
        WHEN cast(`status` AS SIGNED) > 44 AND vacant_time IS NOT NULL AND vacant_time != '' 
            THEN '3'
        WHEN cast(`status` AS SIGNED) > 44 AND move_date IS NOT NULL AND move_date != '' 
            THEN '2'
        WHEN cast(`status` AS SIGNED) > 44 
            THEN '4'
        ELSE '99'
    END AS `status`
FROM t_household 
WHERE  del_flag = '0';
```


## 分页查询

当 offset 偏移量大的时候，sql执行回很慢

* 1、使用 id > $page * $page_size offset 0 limit $page_size
* 2、使用标识位标识 已执行过的数据，通过 do{} while (count($rs) == $page_size)