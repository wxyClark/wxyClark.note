# API 接口规范


## Request

```tip
原则上 【业务接口】统一使用 POST 方式调用，支持大量查询参数的场景

例外：detail 接口使用 GET 方式调用

心跳检测(health) 接口使用 使用 GET方式调用
```

### 参数

* login_user
* auth
* params

```json

```


## Response

* 全局统一返回格式 JSON

```json
{
    "code":10000,
    "data":{
        "标量":322267732559003648,
        "数组":[
            "value1",
            "value2"
        ],
        "对象":{
            "status":true,
            "type":6,
            "notice":"该干啥干啥，和前端约定提示信息呈现方式、可操作按钮"
        },
        "列表数据格式":{
            "total":122,
            "curr_page":7,
            "page_size":20,
            "list":[
                {
                    "arrt1":123.456,
                    "arrt2":"string",
                    "arrt3":true,
                    "status":3
                },
                {
                    "数值":123.456,
                    "str":"字符串",
                    "boolean":true,
                    "status":4
                }
            ]
        }
    },
    "msg":"只提示操作者原因或建议。屏蔽程序内部错误信息(内部错误应给记录日志，不应该暴露出去)"
}
```

## 接口日志
