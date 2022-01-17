---
sort: 1
---

# 架构

在实际工作中，选择稳定版时，尽量避免使用最新的版本，选择比已出来的最新版晚6～10个月的版本比较好。





## 架构选型

## 故障排查
经常查看服务运行日志是个很好的习惯，也是高手的习惯
### MySQL
如发现3306端口没起来，请tail-100/application/mysql/data/机器名.err查看日志信息，看是否有报错信息，然后根据相关错误提示进行调试。

### I/O 多路复用模型

| Linux | Freebsd | Solaris | Windows |
| ---- | ---- |---- |---- |
| epoll | kqueue | /dev/poll | icop |

<hr />

{% include list.liquid all=true %}
