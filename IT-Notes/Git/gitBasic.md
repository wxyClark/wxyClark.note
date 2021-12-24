# git-basic

source: `{{ page.path }}`

## gitPage
    创建 username.github.io项目；必须使用【username】

## git-sshkey
    【git命令行下操作】
    git config --global user.name   "wxy"
    git config --global user.email  "C18666211369@outlook.com"
    检查信息
    git config --global --list

    ssh-keygen -t rsa -C "C18666211369@outlook.com"
    三次回车：默认~/.ssh路径下存放id_rsa.pub、id_rsa.pub文件
    cd ~/.ssh
    cat id_rsa.pub
    复制内容粘贴到 github/gitlab 的 SSH-keys

## git-CRLT
    问题表现：git提交代码时提示

        warning: LF will be replaced by CRLF in package.json.
        The file will have its original line endings in your working directory
    问题原因：不同操作系统使用的换行符是不一样的。

        Unix/Linux使用的是LF，Mac后期也采用了LF，
        但Windows一直使用CRLF【回车(CR, ASCII 13, \r) 换行(LF, ASCII 10, \n)】作为换行符。
    解决方案：禁用git的自动换行功能

        方案一：
            在git命令行下修改全局参数
                git config --global core.autocrlf false
                git config --global core.filemode false
                git config --global core.safecrlf false
        方案二：
            在git命令行vim C:\Users\[用户名]\.gitconfig 文件
            在[core]下添加
                autocrlf = false
                filemode = false
                safecrlf = false
                
## github加速
    获取DNS，修改IP指向
    【一】手动获取
    获取Github相关网站的ip
    访问 https://tool.chinaz.com/dns/
    分别输入github.global.ssl.fastly.net和github.com，查找最快的IP
    写入到host文件中 (运行 drivers 快速定位host文件的上层目录etc)

    【二】下载
    https://cdn.jsdelivr.net/gh/521xueweihan/GitHub520@main/hosts

