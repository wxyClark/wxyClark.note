# apache

## 多主机配置


## 环境变量配置

【问题】：
* windows11系统专业版
* web容器是apache2
* 本地Laravel5.6项目A 通 内部接口调用 本地Laravel5.6项目B
* B项目的sql查询报错，错误信息：Adatabase.Btable 不存在

【原因】：
* getenv() 和 putenv() 不是一个线程安全的函数，意味着如果两个线程同时调用这个函数，就会出现问题
* 而且服务器的环境正好是：Apache + worker 模式，这种模式下 php 运行环境是以线程模式运行的，所以才出现了上述的问题

【方法】：php artisan config:clear