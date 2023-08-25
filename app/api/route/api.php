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
use think\facade\Route;
Route::get('/',function(){return 'hello';});
Route::miss(function() {
    return json_encode([
        'msg'=>'error',
        'code' => '0000'
    ]);
});


// 通过账号密码登录颁发token令牌
Route::rule('gettoken/user','bll.token/GetToken','POST|OPTIONS');
// 通过微信登录颁发token令牌
Route::rule('gettoken/wechat','bll.token/GetToken','POST|OPTIONS');



/**
 * =======================================================================================================================
 * 公共资源接口 把system改成common 不需要验证权限(不经过Auth中间件) 但要验证token(控制器需要继承BaseController)
 */
// 获取当前登录用户的信息
Route::rule('commom/sysuserinfo','pub.System/getUserInfo','GET|OPTIONS');
// 获取渠道来源数据 坑：当有动态参数的时候 路由不是完全匹配模式
Route::rule('api/:version/marketing/channel','public_resource_api/Marketing/getChannel','GET|OPTIONS');
// 获取客户类别
Route::rule('marketing/customertype','pub.Marketing/getCusType','GET|OPTIONS');
// 获取所有用户
Route::rule('commom/sysusers','pub.System/getSysUser','GET|OPTIONS');
// ->allowCrossDomain();

// 获取角色数据
Route::rule('common/sysroles','pub.System/getRoles','GET|OPTIONS');
// 获取部门树结构数据
Route::rule('common/depttree','pub.System/getDpamtTree','GET|OPTIONS');
// 部门数据
Route::rule('common/department','pub.System/getDepartment','GET|OPTIONS');




// data tree
Route::rule('common/datatree','pub.System/getDataTree','GET|OPTIONS');
// 权限规则列表
Route::rule('common/authrules','pub.System/getAuthRules','GET|OPTIONS');
// 菜单
Route::rule('common/menus','pub.System/getMenus','GET|OPTIONS');
// 角色用户组
Route::rule('common/roles','pub.System/getRoles','GET|OPTIONS');
// 原始客户来源
Route::rule('common/originalsource','pub.OriginalCustomer/originalSource','GET|OPTIONS');
// 积分规则
Route::rule('common/pointrules','pub.Project/getPointRules','GET|OPTIONS');
// 问题类别
Route::rule('common/quescategory','pub.Thinktank/getQuesCtg','GET|OPTIONS');
// 上传图片
Route::rule('common/thinktank/upload','pub.Thinktank/uploadImg','POST|OPTIONS');


/**
 * 静态资源接口，不需要token和权限验证
 */
Route::group('res/',function(){
    Route::rule('bingimg','fe.Resources/bingImg','GET|OPTIONS');
});



// 案件办理
Route::group('casehandle/',function(){
    Route::rule('caselist','bll.HandleCase/caseList','POST|OPTIONS'); //案件列表(已分配）
    Route::rule('createahandlerecord','bll.HandleCase/createCaseHandleRecord','POST|OPTIONS'); //新增一条办案记录
    Route::rule('getcasehandlerecords','bll.HandleCase/getCaseHandleRecord','GET|OPTIONS'); //通过uuID查询案件办案记录
    Route::rule('caseHandleevidenceupload','bll.HandleCase/caseHandleEvidenceUpload','POST|OPTIONS'); //案件办理证据录入并上传附件
    Route::rule('updatehandlerecord','bll.HandleCase/updateHandleRecord','POST|OPTIONS'); // 修改案件办理记录
    Route::rule('addcollaborators','bll.HandleCase/addCollaborators','POST|OPTIONS'); // 新增案件协作人员
    Route::rule('cancelcollaborators','bll.HandleCase/cancelCollaborators','DELETE|OPTIONS'); // 取消案件协作人员
    Route::rule('startagentstage','bll.HandleCase/agentstageBegin','POST|OPTIONS'); // 开始某阶段办案
    Route::rule('getmycharge','bll.HandleCase/getMyCharge','GET|OPTIONS'); // 查询当前案件本人的收款记录
    Route::rule('handlecharge','bll.HandleCase/handleCharge','POST|OPTIONS'); // 办案收款
});

// 个人中心
Route::group('personal/',function(){
    Route::rule('personaldata','bll.PersonalData/getPersonalData','GET|OPTIONS'); // 个人数据
    Route::rule('addtodotask','bll.PersonalData/creareTodoTask','POST|OPTIONS'); // 新增待办任务
    Route::rule('monthlytodolist','bll.PersonalData/getTodolistByMonth','GET|OPTIONS'); // 查询我的月历待办事项
    Route::rule('mytodolist','bll.PersonalData/getMyTodoList','POST|OPTIONS'); // 查询我的全部待办任务详情数据
    Route::rule('deletetodolist','bll.PersonalData/deleteTodoList','DELETE|OPTIONS'); // 删除待办事项
    Route::rule('todoliststatistics','bll.PersonalData/todoListStatistics','POST|OPTIONS'); // 待办统计
    Route::rule('updateavatar','bll.PersonalData/uploadAvatar','POST|OPTIONS'); // 修改头像 
});


/**
 * =======================================================================================================================
 * 系统设置
 */
// 获取职员列表
Route::rule('system/stafflist','bll.System/getStaff','POST|OPTIONS');
// 新增职员
Route::rule('system/newstaff','bll.System/addStaff','POST|OPTIONS');
// 修改职员资料
Route::rule('system/updatestaff','bll.System/updateStaff','POST|OPTIONS');
// 添加修改数据字典
Route::rule('system/datadictionary','bll.System/dataDictionary','POST|OPTIONS');
// 修改或新增角色权限
Route::rule('system/authsetting','bll.System/saveAuthRole','POST|OPTIONS');
// 积分规则修改
Route::rule('system/updatepointrule','bll.System/updatePointRule','POST|OPTIONS');
// 修改登陆密码
Route::rule('system/resetpassword','bll.System/resetPassword','POST|OPTIONS');
// 获取操作日志
Route::rule('system/oplog','bll.System/getOplog','POST|OPTIONS');
Route::rule('system/loginlog','bll.System/getLoginlog','POST|OPTIONS');

