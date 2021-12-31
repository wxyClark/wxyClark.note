---
sort: 1
---

# 系统安装
升级Windows 11的最低系统要求：
- CPU:1GHz 双核
- 内存：4G RAM
- 存储：64G
- BIOS: 支持UEFI安全启动
- 显示器：9英寸，720P分辨率
## Win10升级
- 设置——系统更新，等待推送

## Win10硬盘安装
[知乎 无需PE，绕过TPM2.0限制升级Win11](https://zhuanlan.zhihu.com/p/417296843)

[B站 不要PE，绕过TPM2.0限制升级Win11](https://www.bilibili.com/read/cv13789090)
- 下载Win_11_Boot_And_Upgrade_FiX_KiT_v2.0
- Windows11.iso下载 并移动到 TOOL_PATH\\Source_ISO\W11下
- 执行TOOL_PATH\Win_11_Boot_And_Upgrade_FiX_KiT_v2.0汉化by知彼而知己.cmd 文件
- 输入 2 等待脚本执行结束，解压 Windows11_FIXED_2021-12-27.ISO 文件
- 【断网】，执行解压的iso目录下的setup.exe

## U盘安装
- 下载windows官方升级工具
- [制作启动U盘【至少8G】](https://www.bilibili.com/read/cv13486273)
- BIOS修改UEFI启动

### 跳过TPM2.0
[Win11安装前跳过TPM](http://baijiahao.xitongzhijia.net/article/218025.html)
- 按住“Win+R”，输入“regedit”，打开注册表编辑器
- 新建注册表项
```angular2html
    导航到“HKEY_LOCAL_MACHINE\SYSTEM\Setup\MoSetup”，
    右击“MoSetup”，
    选择“新建 -> DWORD（32位）值”，
        输入名称：BypassTPMCheck 值：1
        输入名称：BypassTPMCheck 值：1
```
- 点击ESC 返回，继续安装