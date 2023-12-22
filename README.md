## 介绍

* thinkphp8.0.2 + vue2 + mysql8 后台项目快速开发模版

## 搭建方法

* git clone本项目到本地
* 安装项目依赖 `composer install`
* 导入data.sql数据文件到mysql8数据库,并修改 /app/api/config/database.php 中数据库配置项 注意主机名不能写错 还有.env文件也要修改
* 切换到/public/vue/admin目录下，安装前端项目依赖：`yarn`
* 运行前端项目 `yarn serve`
* 打包前端上线项目 `yarn build`
* 测试账号 admin 123456


如果要全新安装tp8项目： 
`composer create-project topthink/think`  或者 `php composer.phar create-project topthink/think xxx`
`php composer.phar require topthink/think-multi-app` 安装多应用模式扩展
然后把composer.json 和 public/vue/admin文件复制到项目中
把app/api/ app/commom app/middleware 文件夹进行复制
修改app/middleware.php 文件
修改app/provider.php 文件

