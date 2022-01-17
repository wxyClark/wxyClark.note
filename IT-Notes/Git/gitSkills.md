# git小技巧

## git stash

```
git stash 
git checkout branchName
git stash pop
```

## 分支合并错误

开发代码 错误的提交了到测试分支develop,使用stash迁移代码后，强制develop与远端同步
```
git reset --hard origin/master
```