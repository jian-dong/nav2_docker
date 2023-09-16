# nav2 docker 
nav2 ade docker 环境
---

## 安装docker
 * 海外用户参考 [官方文档](https://docs.docker.com/engine/install/ubuntu/)
 * 国内用户参考 [清华大学开源软件镜像站](https://mirrors.tuna.tsinghua.edu.cn/help/docker-ce/)

 如果你过去安装过 docker，先删掉:

```bash
sudo apt-get remove docker docker-engine docker.io containerd runc
```
首先安装依赖:

```bash
sudo apt-get install apt-transport-https ca-certificates curl gnupg2 software-properties-common
```

信任 Docker 的 GPG 公钥:

```bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
```

添加软件仓库:

```bash
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

最后安装

```bash
sudo apt-get update
sudo apt-get install docker-ce
```

为了不每个命令都要敲`sudo`，还需要添加当前用户到docker分组

```bash
sudo groupadd docker
sudo usermod -aG docker $USER
```
需要logout或者reboot才能生效

##  Getting start
安装 ade-cli
```bash
wget https://gitlab.com/ApexAI/ade-cli/-/jobs/1341322851/artifacts/raw/dist/ade+x86_64
#如果您的网络不好没法下载可以直接在把 `bin/` 下面的ade直接copy到 `/usr/local/bin`下面去
mv ade+x86_64 ade
chmod +x ade
mv ade /usr/local/bin
```

补全, 把下面的代码copy到你的`.zshrc`或者 `.bashrc`

```bash
if [ -n "$ZSH_VERSION" ]; then
    eval "$(_ADE_COMPLETE=source_zsh ade)"
else
    eval "$(_ADE_COMPLETE=source ade)"
fi
```
* 构建docker

```bash
./build.sh

```

* 使用

新建 workspace

```
mkdir -p ~/ros2_ws/src
```
把 `navigation2`放到src中

设置 `adehome`, 

```bash
cd ~/ros2_ws
touch .adehome
```
表示 docker 会挂载 `~/ros2_ws`作为 container的home,你也可以挂载其他文件夹

设置 `.aderc`

```bash
cd ~/ros2_ws
touch .aderc
```

添加

```bash
export ADE_DOCKER_RUN_ARGS="--cap-add=SYS_PTRACE
 --net=host
 --add-host ade:127.0.0.1
 -v ${HOME}/.Xauthority:${HOME}/.Xauthority:ro
 -e XAUTHORITY=${HOME}/.Xauthority -e RMW_IMPLEMENTATION=rmw_cyclonedds_cpp 
 -v /dev:/dev
 -e ROS_DOMAIN_ID=42
 -e ROS_LOCALHOST_ONLY=1
 --device /dev/Femto"

export ADE_IMAGES="
 nav2_docker_env:x86_humble
 "
```

`--device`是吧相机挂载到docker里面去
不同相机名字不一样

开启container, cd 到你放 `.aderc`那个目录

```bash
ade start
ade enter zsh
```
现在你应该在docker container 里面了。
