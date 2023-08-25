<?php

namespace app\api\controller\bll;

use app\api\model\SysUsers as SysUsersModel;
use app\api\model\SyslogOplog as SyslogOplogModel;
use app\api\model\SyslogLogin as SyslogLoginModel;
use app\api\model\PointsRule as PointsRuleModel;
use app\api\model\AuthRole as AuthRoleModel;
use app\api\validate\Staff as StaffValidate;
use app\commom\exception\SuccessMessage;
use think\facade\Request;
use think\facade\Db;
use app\api\service\BaseToken;
// 系统设置
class System extends BaseController
{
    // 获取职员列表
    public function getStaff(){
        // $where = ['status'=>$jobstatus];
        // if($jobstatus == ''){
        //     $where = [];
        // }
        // $staffList = SysUsersModel::where($where)->order('create_time')->with(['roles','dept','dept.parentDept'])->paginate($pagesize,false,['var_page' => 'pageSize'])->toArray();
        // foreach ($staffList['data'] as &$staff) {
        //     $temp = [];
        //     foreach ($staff['roles'] as $role) {
        //         $temp[] = [
        //             'id' => $role['id'],
        //             'name' => $role['name']
        //         ];
        //     }
        //     $staff['roles'] = $temp;
        //     // var_dump($staff);
        // }
        // unset($staff); // 销毁$staff引用
        // return $staffList;

        $params = Request::param();

        $where = [];
        $fuzzy_keyword = $params['fuzzy_keyword'];
        
        
        if(!empty($params['jobstatus']) || $params['jobstatus'] == 0){
            $where[] = ['status','=',$params['jobstatus']];
        }
    


        $res = SysUsersModel::whereRaw("instr (concat(username,realname,IFNULL(phone,'')),'$fuzzy_keyword') > 0")
        ->where($where)
        ->with(['roles','dept','dept.parentDept'])
        ->order('create_time','desc')
        ->paginate([
            'list_rows'=> $params['pageSize'],
            'var_page' => 'currentPage',
            'query' => Request::param()
        ]);
        
        
            

        return json($res);
    }

    // 新增职员
    public function addStaff(){
        (new StaffValidate)->goCheck();
        $data = Request::only(['username','password','realname','phone','sex','roles','staff_dept']);
        $data['password'] = password_hash(trim($data['password']), PASSWORD_DEFAULT);
        // $data['dept_id'] = $data['staff_dept'][1]??$data['staff_dept'][0];
        $data['dept_id'] = end($data['staff_dept']);
        // return $data;
        $staff = SysUsersModel::create($data);
        if($staff->id){
            // 设置职员角色
            $staff->roles()->saveAll($data['roles']);
            throw new SuccessMessage;
        }
    }
    // 修改职员资料
    public function updateStaff(){
        $data = Request::only(['id','username','password','realname','phone','sex','roles','staff_dept','status']);
        if(isset($data['password']) && $data['password']){
            $data['password'] = password_hash(trim($data['password']), PASSWORD_DEFAULT);
            // dump($data['password']);
        }
        $data['dept_id'] = end($data['staff_dept']);//获取数组最后一个元素的值
        // return $data;
        $staff = SysUsersModel::find($data['id']);
        $staff->save($data);
        // 多对多关联更新 先删除所有再添加
        $staff->roles()->detach();
        $staff->roles()->attach($data['roles']);
        throw new SuccessMessage;
    }

    // 新增或修改数据字典
    public function dataDictionary(){
        $name = Request::param('name');
        $tableName = Request::param('code');
        $postData = Request::only(['id','status','sort','pid',$name]);
        // dump($postData);
        if (isset($postData['id'])) {
            // 更新
            // $data = $postData;
            Db::name($tableName)
            ->update($postData);
            // $data[$postData['name']];
            return '修改成功';
        } else {
            // 新增
            Db::name($tableName)
            ->data($postData)
            ->insert();
            return '新增成功';
        }
    }
    // 修改或新增角色权限
    public function saveAuthRole() {
        // return $this->request->role_view_scope;
        $postData = Request::only(['id','name','rules_id','menu_id','view_scope']);
        $menusId = $postData['menu_id'];
        unset($postData['menu_id']);
        if (isset($postData['id'])) {
            // 更新
            Db::name('auth_role')
            ->update($postData);

            $this->updateMenuAuth($postData['id'],$menusId);
            return '修改成功';
        } else {
            $roleId = Db::name('auth_role')->insertGetId($postData);
            $this->updateMenuAuth($roleId,$menusId);
            return '新增成功';
        }
    }
    // 修改菜单权限
    private function updateMenuAuth($roleId,$menusId){
        $role = AuthRoleModel::find($roleId);
        // halt($role);
        if($role){
            // 多对多更新中间表
            // 方式一
            $role->menus()->sync($menusId);

            // 方式二
            /*
            $role->menus()->detach();
            $role->menus()->attach($menusId);
            */
        }
    }
    // 修改登陆密码
    public function resetPassword(){
        $uid = BaseToken::getCurrentUid();
        $new_pass = input('post.new_password');
        $pass = password_hash(trim($new_pass), PASSWORD_DEFAULT);
        
        if($uid>0){
            return SysUsersModel::where('id',$uid)->update(['password' => $pass]);
        }
    }

    // 积分规则修改
    public function updatePointRule()
    {
        $data = Request::only(['id','rule_name','rule_desc','point']);
       $res = PointsRuleModel::update($data);
        return json($res);
    }

    // 查询操作日志
    public function getOplog(){
        $params = Request::param();
        $where = [];

        $fuzzy_keyword = $params['fuzzy_keyword'];
        if(!empty($params['date'])){
            $startTime = strtotime(date('Y-m-d 00:00:00',$params['date'][0]/1000));
            $endTime = strtotime(date('Y-m-d 23:59:59',$params['date'][1]/1000));
            $where[] = ['create_time','between',[$startTime,$endTime]];
        }
        if(!empty($params['uid'])){
            $where[] = ['user_id','=',$params['uid']];
        }
        // $where[] = ['status','=',1];
        $res = SyslogOplogModel::with(['apirule','user'])
        ->whereRaw("instr (param,'$fuzzy_keyword') > 0")
        ->where($where)
        ->order('create_time desc')
        ->paginate([
            'list_rows'=> $params['pageSize'],
            'var_page' => 'currentPage',
            'query' => Request::param()
        ]);
        return json($res);
    }

    // 查询登录日志
    public function getLoginlog(){
        $params = Request::param();
        $where = [];

        if(!empty($params['date'])){
            $startTime = strtotime(date('Y-m-d 00:00:00',$params['date'][0]/1000));
            $endTime = strtotime(date('Y-m-d 23:59:59',$params['date'][1]/1000));
            $where[] = ['create_time','between',[$startTime,$endTime]];
        }
        if(!empty($params['uid'])){
            $where[] = ['user_id','=',$params['uid']];
        }
        // $where[] = ['status','=',1];
        $res = SyslogLoginModel::with(['user'])
        ->where($where)
        ->order('create_time desc')
        ->paginate([
            'list_rows'=> $params['pageSize'],
            'var_page' => 'currentPage',
            'query' => Request::param()
        ]);
        return json($res);
    }
}
