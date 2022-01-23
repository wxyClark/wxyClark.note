---
sort: 4
---

# 结构图

[markdown 中流程图详解](https://blog.csdn.net/suoxd123/article/details/84992282)

[文档](https://www.wenjiangs.com/doc/markdown-markdownflowchart)

[web216安全色](http://www.h-ui.net/websafecolors.shtml)

* 默认节点： A
* 矩形节点： B[矩形]
* 圆角矩形节点： C(圆角矩形)
* 圆形节点： D((圆形))
* 非对称节点： E>非对称]
* 菱形节点： F{菱形}

* 开始（椭圆形）：start
* 结束（椭圆形）：end
* 操作（矩形）：operation
* 多输出操作（矩形）：parallel
* 条件判断（菱形）：condition
* 输入输出（平行四边形）：inputoutput
* 预处理/子程序（圣旨形）：subroutine

## 文本


## 跨部门流程图
```mermaid

graph TB
    c1-->a2
    subgraph one
    a1-->a2
    end
    subgraph two
    b1-->b2
    end
    subgraph three
    c1-->c2
    end
```

## 流程图
```mermaid
graph TD;
    A-->B;
    A-->C;
    B-->D;
    C-->D;
```

## 类图
```mermaid
classDiagram
classA <|-- classB
classC *-- classD
classE o-- classF
classG <-- classH
classI -- classJ
classK <.. classL
classM <|.. classN
classO .. classP
```

## E-R图
```mermaid
erDiagram
    CUSTOMER ||--o{ ORDER : places
    ORDER ||--|{ LINE-ITEM : contains
    CUSTOMER }|..|{ DELIVERY-ADDRESS : uses
```

## 流程图

```mermaid
	graph TB
	A[Apple]-->B{Boy}
	A---C(Cat)
	B.->D((Dog))
	C==喵==>D
	style A fill:#2ff,fill-opacity:0.1,stroke:#faa,stroke-width:4px
	style D stroke:#000,stroke-width:8px;
```


## 时序图

```mermaid
    sequenceDiagram
    participant 张 as 张三
    participant 李 as 李四
    participant 王 as  王五   
    张 ->> +李: 你好！李四, 最近怎么样?
    李-->> 王: 你最近怎么样，王五？
    李--x -张: 我很好，谢谢!
    activate 王
    李-x 王: 我很好，谢谢!   
    Note over 李,王: 李四想了很长时间, 文字太长了<br/>不适合放在一行.
    deactivate 王
    loop 李四再想想
    李-->>王: 我还要想想
    王-->>李: 想想吧
    end
    李-->>张: 打量着王五...
    张->>王: 很好... 王五, 你怎么样?
```


## 消息流

```mermaid
    sequenceDiagram
    participant 张 as 张三
    participant 李 as 李四
    张 ->> 李: 你好！李四, 最近怎么样?
    alt 如果感冒了
    李->> 张: 不太好，生病了。
    else 挺好的
    李->> 张: 我很好，谢谢。
    end
        opt 另外补充
        李->> 张: 谢谢问候。
    end
```
