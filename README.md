# terraria-docker
泰拉瑞亚docker项目，当前版本为1.4.2.3，默认密码`JOJO`

## 使用docker hub上的镜像
```bash
docker pull gknoone/terraria:1.4.2.3
docker run -id --name "terraria" -p 7778:7777 gknoone/terraria:1.4.2.3
docker ps | grep 'terraria'
```
## 修改容器（建议）
> 每次启动的时候都会生成一个新的世界，如果不想生成新的世界，防止容器幽灵挂掉后重启。可以进行如下操作。

```bash
# 进入容器
docker exec -it `docker ps |grep 'terraria' |awk '{print $1}'` bash
# 查看screen，进入screen
cd /opt/terraria
screen -ls
## 第一次进入加载会比较慢，因为在创建世界
screen -R terraria
```
![](https://cdn.jsdelivr.net/gh/uyaki/pic-cloud/img/20210808161039.png)
- 输入`exit`
```bash
# 编辑配置文件，在autocreate、worldname、difficulty这3行前面加上#号
vi /opt/terraria/serverconfig.txt

# 重启
nohup /opt/terraria/terra_script.sh start &

## 查看重启结果
screen -R terraria
```
此时按`ctrl+A+D`可以安全退出
## 开放端口
```bash
firewall-cmd --permanent --add-port=7778/tcp
firewall-cmd --reload
```
---

## 自己构建，可更换泰拉瑞亚版本

1. 下载项目
```bash
git clone "git@github.com:uyaki/terraria-docker.git"
```
2. 工作目录为`/opt`
3. 更换泰拉瑞亚版本

- 下载需要的服务器版本[terrari wiki](https://terraria.fandom.com/zh/wiki/Terraria_Wiki)，下载得到最新的zip包
- 解压替换当前版本，替换路径：`/opt/terraria/bin/{version}`
- 修改启动脚本terra_script.sh
```bash
# 替换为当前对应的版本文件夹名
TERA_VER='1423'
```
- 重新打包镜像
```bash
docker build -t terraria:latest .
```