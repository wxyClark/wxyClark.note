# Nginx配置

配置规则尽可能清晰准确

## Nginx解析顺序
* Nginx首先会搜索确切名字的散列表，
* 如果没有找到，则搜索以星号起始的通配符名字的散列表，
* 如果还是没有找到，继续搜索以星号结束的通配符名字的散列表。
* 因为名字是按照域名的字节来搜索的，所以搜索通配符名字的散列表比搜索确切名字的散列表慢

## demo

### /etc/nginx/nginx.conf

```
# 设置nginx服务的系统使用用户
user  nginx; 
# 工作进程数，默认=CPU核数，高并发时可设置2倍
worker_processes  4; 
# 0001 0010 0100 1000是掩码，分别代表第1、2、3、4核CPU
worker_cpu_affinity 0001 0010 0100 1000;

error_log  /var/log/nginx/error.log warn;  // nginx的错误日志
pid        /var/run/nginx.pid;      // nginx服务启动时候pid

error_page   500 502 503 504  /50x.html

events {        
    # 【事件处理模型】linux下默认 epoll, 手动配置的话需要在events模块下
    # Nginx官方文档建议，可以不指定，Nginx会自动选择最佳的事件处理模型服务

    # 最大客户端连接数由 = worker_processes * worker_connections
    # 进程的最大连接数 受Linux系统进程的最大打开文件数限制
    # 执行操作系统命令“ulimit -HSn 65535”或配置，worker_connections的设置才能生效
    worker_rlimit_nofile 65535;
    
    # 每个worker进程允许的最大连接数，默认1024
    worker_connections  1024;    
}


http {                                                  
    include       /etc/nginx/mime.types;  //设置contentType
    default_type  application/octet-stream;

    # 隐藏Nginx版本号,错误页面泄露
    nserver_tokens off;

    # 默认值可能是32或64，也可能是其他值，这取决于CPU的缓存行的长度
    # 如果这个值是32，那么定义“too.long.server.name.nginx.org”作为虚拟主机名就会失败，
    # 此时会显示下面的错误信息： could not build the server_names_hash
    server_names_hash_bucket_size 64;

    # 值差不多等于名字列表的名字总量,默认是512kb，
    # 一般要查看系统给出确切的值。这里一般是cpu L1 的4-5倍
    server_names_hash_max_size 512;

    # 开启高效文件传输模式,可防止网络及磁盘I/O阻塞，提升Nginx工作效率
    sendfile on;
    tcp_nopush on;
    tcp_nodelay on;

    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '     // 定义日志类型
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile        on; //  快速发送
    #tcp_nopush     on;

    keepalive_timeout 65;  #连接(服务端)超时时间，默认为75s，可以在http，server，location块。

    #gzip  on;

    include /etc/nginx/conf.d/*.conf;      // 读到这个地方是加载另一个默认配置配置文件default.conf
}
```

##  Nginx rewrite 重写规则
last和break用来实现URL重写，浏览器地址栏的URL地址不变，但在服务器端访问的程序及路径发生了变化
### last
* 在根location（即location/{……}）中或server{……}标签中编写rewrite规则，建议使用last标记
* 使用alias指令时必须用last标记
* last标记在本条rewrite规则执行完毕后，会对其所在的server{......}标签重新发起请求

### break
* 在普通的location（例location/oldboy/{……}或if{}）中编写rewrite规则，则建议使用break标记
* 使用proxy_pass指令时要使用break标记
* break标则会在本条规则匹配完成后，终止匹配，不再匹配后面的规则

## Nginx访问认证
* auth_basic "请输入授权账号"；用于设置认证提示字符串(web弹窗)"请输入授权账号"。 
* auth_basic_user_file/application/nginx/conf/htpasswd；用于设置认证的密码文件