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
* uua 用户系统
* wms 仓库系统(warehourse)

## 分层

### 前端入口

### 网关校验

### 子系统

* 前后端严格分离,解耦
* 上传由前段把文件转为base64编码，加签传递给后端
* 后端处理完上传，返回文件url给前段
* 后端异步处理文件导入，在打入结果页展示结果和失败原因
* 下载由后端处理数据生成下载文件，发送文件url给前端

## 调用
前端调用 子系统 验签

子系统之间调用 使用另一套验签 + IP验证

<hr />
{% include list.liquid all=true %}
