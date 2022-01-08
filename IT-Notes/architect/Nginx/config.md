# Nginx配置

## demo

```
vim /etc/nginx/nginx.conf

user  nginx;    // 设置nginx服务的系统使用用户
worker_processes  4;   // 工作进程数，默认=CPU核数，高并发时可设置2倍

error_log  /var/log/nginx/error.log warn;  // nginx的错误日志
pid        /var/run/nginx.pid;      // nginx服务启动时候pid

error_page   500 502 503 504  /50x.html

events {                                                      
    // 事件模块，nginx优势利用epoll内核模型，在这里可以配置使用哪个内核模型。【建议】不配置，Nginx会选择最合适的来使用
    // 每个worker进程允许的最大连接数 ，还有个use是工作进程数
    worker_connections  1024;    
}


http {                                                  
    include       /etc/nginx/mime.types;  //设置contentType
    default_type  application/octet-stream;

    # 隐藏Nginx版本号,错误页面泄露
    nserver_tokens off;

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