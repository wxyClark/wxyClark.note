# Linux

## 规则

### 权限最小化原则

### 更改配置前进行备份

### 平滑重启
* sshd nginx 等支持reload 的重启命令，优先使用reload，减少影响
* 有临时生效设置的，使用 临时+永久 不立即重启的方式配置，减少重启次数



{% include list.liquid all=true %}
