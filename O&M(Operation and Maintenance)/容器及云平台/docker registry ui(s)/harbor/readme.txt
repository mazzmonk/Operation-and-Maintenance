当系统部署完成以后,docker必须不能设置代理下载,否则,docker push x.x.x.x,会有harbor denied: requested access to the resource is denied报错

2个harbor之间可以触发同步,包括上传,删除等等操作,操作可以是手动,事件触发,或者计划任务

比如:
$ docker push 172.20.20.1:28080/example/alpine:3.10

这里的example必须通过harbor登录以后在项目中存在

使用命令行模式push的时候,如下:
$ docker login 172.20.20.1:28080
user:admin
password:xxxxx

用户名密码存在
$HOME/.docker/config.json


