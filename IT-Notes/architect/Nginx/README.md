# Nginx Web服务

【面试常考】Apache select和Nginx epoll模型的区别

Nginx有Master进程和worker进程之分

## web容器优选Nginx

* 备支持高性能，高并发的特性，并发连接可达数万。 对小文件（小于1MB的静态文件）高并发支持很好，性能很高。

* PHP引擎支持的并发连接参考值为300～1000，Java引擎和数据库的并发连接参考值则为300～1500。

* Nginx结合Tomcat/Resin等支持Java动态程序（常用proxy_pass方式）

* 异步网络I/O事件模型epoll（Linux 2.6+）

* 这条ln命令的意义十分深远重大。这可是生产环境的经验。
```
ln -s /application/nginx-版本号 /application/nginx
```

{% include list.liquid all=true %}
