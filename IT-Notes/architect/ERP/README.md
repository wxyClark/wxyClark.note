---
sort: 1
---

# 电商ERP架构实践

| 项目名 | 业务域  | 备注 |
| ---- | ---- |---- |
| analysis | 大数据计算 | 默认只有这个项目可以使用连表操作，其他项目make生成Repository单表操作代码 |
| BI | 商务智能(Business Intelligence) | 采购分析、运营策略  |
| common | 基础配置 | 系统控制，基础数据，规则 |
| downloads | 下载中心 | C |
| A | B | C |
| A | B | C |


* financial 财务系统 
* goods 商品系统
* instant-kill 秒杀/闪购 系统
* listing 刊登系统(商品展示)
* monitor 监控系统
* notice 通知系统
* oms 订单系统(order)
* pms 采购系统(purchase)
* Promotion 促销系统
* report-form 报表系统
* uc 用户中心
* wms 仓库系统(warehourse)

## 分层

* 网关层
* 路由-权限中间件
* 控制器(区分web、api、auth、inner目录)
* 控制器调度(Request参数校验、Service处理业务、统一的返回格式、异常处理)
  > Request参数校验 只校验数据格式
  
  > 默认参数填充
  
  > Response 返回统一的(code、data、msg; 集中定义错误码)
* Service 层调用 Repository 读取数据、更新数据 分离
  > 事务处理
  
  > 日志记录
* Repository 层调用 Model 操作数据库
  > 定义通用方法，提升复用性
* Model 层只做数据映射和字段定义

### 前端入口

### 网关校验

* 签名算法

### 子系统

* 前后端严格分离,解耦
* 上传由前段把文件转为base64编码，加签传递给后端
* 后端处理完上传，返回文件url给前段
* 后端异步处理文件导入，在打入结果页展示结果和失败原因
* 下载由后端处理数据生成下载文件，发送文件url给前端

## 调用
前端调用 子系统 验签

子系统之间调用 使用另一套验签 + IP验证

## 技术方案

### 数据报表

```tip
报表系统设计：

同一套业务数据不同维度的报表，只设计一套定时脚本

按最多维度(最细粒度)分析，入库到 analysis_base_业务名 表中

不同维度的聚合数据，用不同页面展示；通过 基础分析表 清洗出聚合数据，存到对应表中(支持分页，排序)
```


### 自动配置

```tip
开关控制：启用、停用

处理脚本：判定开关，定时执行，避免锁表、争用
s
自动处理数据：区分不同条件对应的策略，事务提价

日志：记录明细过程、数据
```

<hr />
{% include list.liquid all=true %}
