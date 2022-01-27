# git小技巧

## 版本控制最佳做法

* 提交代码之前一定要先测试——在你还没有确认工作完成(彻底的测试)之前，忍住提交代码的冲动
* 提交应该是相关更改的封装——较小的提交可使其他开发人员更容易理解更改，并在出现问题时将其回滚。
* 写”好”的提交注释——用简短的总结语句，后续正文与开头用空白行分开。——做了什么，为什么这样做
* 经常提交会使你的提交变小，并且帮助你仅提交相关的更改。——可以更轻松地定期同步整合代码更改，并避免合并冲突
* 不要提交未完成的代码——将功能的实现分成逻辑块，并记住要尽可能早的频繁的提交
* 如果你只是因为需要干净的工作区（切换分支，同步更改等）而打算提交未完成的代码，请考虑改用git stash


## 分支合并错误

开发代码 错误的提交了到测试分支develop,使用stash迁移代码后，强制develop与远端同步

```bash
git reset --hard origin/master
```

## 重写最近commit message


```bash
git commit --amend '新的注释'
```
 

 ## 移花接木

 ```bash
# 复制一个特定的提交到当前分支
git cherry-pick <commit_id>

# 未提交代码转移分支 使用stash
git stash 
git checkout branchName
git stash pop

# 提交到错误分支的代码转移分支 使用stash
git reset --soft <commit_id>
git stash 
git checkout branchName
git stash pop

# 删除误提交的代码
git reset —hard <commit_id>
 ```

 ## 查看修改日志

| 命令 | 用途 | 备注 |
| ---- | ---- |---- |
| git reflog | 查看命令历史 | 完整信息 |
| git log | 查看详细提交历史 | 完整信息 |
| git log --pretty=oneline | 查看简化提交历史 | commit message |
| git log --graph | 查看分支合并图 | 图 |
| git log -p <file> | 显示特定文件随时间的修改 | 详情 |
| git blame <file> | 查看特定文件什么时间被什么人修改了什么内容 | 列表 |

## 配置

* 查看全部Git配置   git config --list
* 显示颜色提示      git config --global color.ui true

## 工作流

```tip
开发分支——>测试分支 合并 只能是单向合并，【test分支部分代码验证不通过，不能影响其他开发分支上线】

合并分支前 同步远端分支 git fetch origin branchName
```

### 版本一：小规模开发

* 基于 master 发布
* 基于 master 创建开发分支 feature/userName/Date/featureName
* 基于 master 创建修复分支 bugix/userName/Date/featureName
* 基于 develop 测试
* 自测通过的代码合并到 develop 分支【单向合并】
* git fetch origin master
* 产品验收通过的分支提交 mergeRequest 到 master

### 版本二：中规模开发

【迭代开发】

* 基于 released 分支发布
* 基于 develop 创建开发主分支 dev-Version
* 基于开发主分支 dev-Version 创建独立开发分支 dev-Version-ModuleName/userName/Date
* 自测通过的代码合并到 dev-Version 分支【单向合并】
* 基于 develop 分支【+迭代版本号】创建 test-Version
* 联测通过的代码合并到 test-Version 分支【单向合并】
* 产品验收通过的 dev 分支提交 mergeRequest 到 develop
* 运维基于 develop + 封版时间 创建 released-Version 分支
* 发版之后，将 released-Version 分支 合并到 master 【?合并时机】

【bug修复】

* 基于 develop 分支创建修复分支 released-Version-bugfix-Version
* 基于 released-Version-bugfix-Version 分支创建独立修复分支 released-Version-bugfix-Version/userName/bugName
* 自测通过的代码合并到 test-Version 分支【单向合并】
* 产品验收通过的分支提交 mergeRequest 到 released-Version-bugfix-Version
* 运维 基于 released-Version-bugfix-Version + 例行bug修复封版时间 发版
* 发版之后，将 released-Version-bugfix-Version 分支 合并到 develop、master
  

### 版本三：双周灰度发布

* 全量发布的分支不再创建 released-Version-bugfix-Version 分支

| 周一 | 周二 | 周三 | 周四 | 周五 | 周六 | 周日 | 周一 | 周二 | 周三 | 周四 | 周五 | 周六 | 周日 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | 2  | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 | 13 | 14 |
| <需> | 例 |  | Ver2-1<br>一灰 3% | **技** | - | - | <需> | 例 |  | Ver2-2<br>二灰 10% | **技** | - | - |
| <求> | 行 |  | Ver1-3<br>三灰 25% | **术** | - | - | <求> | 行 |  | Ver1-4<br>全量 100% | **术** | - | - |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| <评> | bug |  | Ver2-3<br>三灰 25% | **分** | - | - | <评> | bug |  | Ver2-4<br>全量 100% | **分** | - | - |
| <审> | 修复 |  | Ver3-1<br>一灰 3% | **享** | - | - | <审> | 修复 |  | Ver3-2<br>二灰 10% | **享** | - | - |
| 15 | 16  | 17 | 18 | 19 | 20 | 21 | 22 | 23 | 24 | 25 | 26 | 27 | 28 |
| 周一 | 周二 | 周三 | 周四 | 周五 | 周六 | 周日 | 周一 | 周二 | 周三 | 周四 | 周五 | 周六 | 周日 |