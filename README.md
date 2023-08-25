## 介绍

* thinkphp8.0.2 + vue2 + mysql8 后台项目快速开发模版

## 搭建方法

* git clone本项目到本地，如果要全新安装tp8项目： `composer create-project topthink/think` 然后把composer.json 和 public/vue/admin文件复制到项目中
* 安装项目依赖 `composer install`
* 导入data.sql数据文件到mysql8数据库,并修改 /app/api/config/database.php 中数据库配置项
* 切换到/public/vue/admin目录下，安装前端项目依赖：`yarn`
* 运行前端项目 `yarn serve`
* 打包前端上线项目 `yarn build`


