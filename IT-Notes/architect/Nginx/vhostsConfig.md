# 虚拟主机配置

```
vim /etc/nginx/conf.d/default.conf
server {
    keepalive_requests 120; #单连接请求上限次数。

    listen       80;   #监听端口
    server_name  local.test.com;   #域名   

    # 项目根目录、入口文件
    root /data/www/project_dir_name/;
    index index.php index.html index.htm;

  
    location ~ \.php$ {
        # nginx会调用fastcgi接口
        include /etc/nginx/fastcgi_params;  
        # 开启fastcgi的中断和错误信息记录
        fastcgi_intercept_errors on; 
        # nginx通过fastcgi_pass将用户请求的资源发php-fpm处理
        fastcgi_pass 127.0.0.1:9000;
    }

    # 当找不到首页文件时，会展示目录结构，这个功能一般不要用，除非有需求(如：文件下载站点、镜像站点)
    autoindex on；     
    autoindex_exact_size off;   # 显示文件大小 on:单位是bytes;off：单位转成(k、M、G)易读模式
    autoindex_localtime on; # 显示文件时间 on:服务器时间;off:GMT时间

    # 入口文件
    location / {
        try_files $uri $uri/ /index.php;
    }

    # 禁止web直接访问nginx状态，设置白名单
    location /nginx_status {
        stub_status on;
        access_lg off;
        allow 127.0.0.1;
        deny all;
    }

    location  ~*^.+$ {       
        #请求的url过滤，正则匹配，~为区分大小写，~*为不区分大小写。
        #root path;  #根目录
        #index vv.txt;  #设置默认页
        proxy_pass  http://mysvr;  #请求转向mysvr 定义的服务器列表
        deny 127.0.0.1;  #拒绝的ip
        allow 172.18.5.54; #允许的ip           
    } 

    listen       443;   #监听端口 https
}
```