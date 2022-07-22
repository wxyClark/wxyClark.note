# 用户中心

## 用户模板

### tenant租户表

| 字段 | 类型 | 约束 | 默认值 | 备注 |
| ---- | ---- | ---- | ---- | ---- |
| id | bigint | unsigned,自增 | 0 | 与业务无关 |
| tenant_id | bigint | unsigned<br>unique | 0 | 自增<br>与业务无关<br>所有表比备字段 |
| group_name | varchar(32) | ？唯一 | '' | 集团名称 |
| type | smallInt | unsigned | 0 | 行业类型 |
| status | tinyInt | unsigned | 0 | 状态(1:新注册;2:使用中;3:暂停;4:注销) |
| level | tinyInt | unsigned | 0 | 等级(1:青铜;2:白银;3:黄金;4:铂金;5:钻石) |
| logo | varchar(255) | NOT NULL | '' | 集团Logo(图片URL) |
|  |  |  |  |  |
| created_at | datetime | 不支持手动修改 | CURRENT_TIME ON INSERT | 创建时间 |
| created_by | bigInt | unsigned | 0 | 创建人<br>日志表记录名称，业务表记录ID |
| updated_at | datetime | 不支持手动修改 | CURRENT_TIME ON UPDATE | 修改时间 |
| updated_by | bigInt | unsigned | 0 | 修改人<br>日志表记录名称，业务表记录ID |


### user用户表

| 字段 | 类型 | 约束 | 默认值 | 备注 |
| ---- | ---- | ---- | ---- | ---- |
| id | bigint | unsigned,自增 | 0 | 与业务无关 |
| tenant_id | bigint | unsigned | 0 | 自增<br>与业务无关<br>所有表比备字段 |
| user_name | varchar(32) | 租户下唯一 | '' | 用户名 |
| email | varchar(255) | unsigned | '' | 邮箱 |
| phone | varchar(20) | unsigned | '' | 手机号 |
| password | varchar(64) | unsigned | '' | 密码 |
| token | varchar(256) | unsigned | '' | 令牌 |
| token_expired | dateTime | unsigned | '1970-01-01 08:00:01' | 令牌过期时间 |
| refresh_token | varchar(256) | unsigned | '' | 更换令牌 |
| status | tinyInt | unsigned | 0 | 状态(1:在职;2:休假;3:离职;) |
| role | bigInt | unsigned | 0 | 状态(1:在职;2:休假;3:离职;) |
|  |  |  |  |  |
| created_at | datetime | 不支持手动修改 | CURRENT_TIME ON INSERT | 创建时间 |
| created_by | bigInt | unsigned | 0 | 创建人<br>日志表记录名称，业务表记录ID |
| updated_at | datetime | 不支持手动修改 | CURRENT_TIME ON UPDATE | 修改时间 |
| updated_by | bigInt | unsigned | 0 | 修改人<br>日志表记录名称，业务表记录ID |

### user_role用户角色表

* 一个用户可以有多个角色
* 用户权限 = 所有角色 的 role_auth 合集

### user_login_log用户登录日志表


## RBAC模板

### role角色表

### api接口表

### api_permission 接口权限表

* 无限极分类
* 顶级分类，parent_id = 0

### role_auth 角色权限表

* 权限类型：1 api; 2 api_group
* role_auth 最终解析到 api维度


## employee_structure组织架构表

### department部门表