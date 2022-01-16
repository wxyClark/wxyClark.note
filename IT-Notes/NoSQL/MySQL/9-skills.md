# 奇技淫巧

# CASE WHEN...THEN

```
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
