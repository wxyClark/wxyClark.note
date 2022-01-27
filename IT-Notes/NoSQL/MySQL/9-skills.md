---
sort: 9
---

# 奇技淫巧

## CASE WHEN...THEN

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

```tip
分页读取数据 后修改数据 要考虑 使用 page++ 还是 page==1

如果修改的数据导致查询结果集变化，则应使用page==1 避免跳过了一半数据 
```

当 offset 偏移量大的时候，sql执行回很慢

* 1、使用 id > $page * $page_size offset 0 limit $page_size
* 2、使用标识位标识 已执行过的数据，通过 do{} while (count($rs) == $page_size)
* 3、分页数据状态修改后，