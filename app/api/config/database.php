<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006~2018 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: liu21st <liu21st@gmail.com>
// +----------------------------------------------------------------------

return [
    'connections' => [
        'mysql' => [
            // 数据库类型
            'type'        => 'mysql',
            // 服务器地址
            'hostname'        => '127.0.0.1',
            // 数据库名
            'database'        => 'bc-business',
            // 用户名
            'username'        => 'root',
            // 密码
            'password'        => 'root',
            // 数据库表前缀
            'prefix'          => 'bc_',
            // 连接数据库编码
            'charset'         => 'utf8mb4'
        ]
    ]
    
];
