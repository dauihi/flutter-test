<?php
$mysql_server_name = "127.0.0.1"; //数据库服务器名称
$mysql_username = "root"; // 连接数据库用户名
$mysql_password = "123456"; // 连接数据库密码
$mysql_database = "test"; // 数据库的名字
$mysql_table = "user"; //表名

// 连接到数据库
$conn = mysqli_connect(
    $mysql_server_name,
    $mysql_username,
    $mysql_password,
    $mysql_database
);
if (!$conn) {
    echo "数据库连接失败！";
}
mysqli_select_db($conn, $mysql_database);

//获取url参数
$action = isset($_POST['action']) ? $_POST['action'] : '';
$name = isset($_POST['name']) ? $_POST['name'] : '';
$pwd = isset($_POST['pwd']) ? $_POST['pwd'] : '';

if ($action == 'login') {
    login($name, $pwd, true);
} else if ($action == 'register') {
    register($name, $pwd);
} else if ($action == 'modifypwd') {
    modifypwd($name, $pwd);
} else if ($action == 'showAll') {
    showAll();
} else {
    $result = array("result" => "error_request");
    $json = json_encode($result);
    echo $json;
}

close_conn();

/*用户登录*/
function login($name, $pwd, $normal)
{
    global $conn;
    global $mysql_table;

    if ($conn) {
        $result = mysqli_query($conn, "select name,pwd from $mysql_table");
        $success = false;
        while ($row = mysqli_fetch_array($result)) {
            if ($name == $row['name'] && $pwd == $row['pwd']) {
                $success = true;
            }
        }
        if ($normal) {
            $login_result = array('login_result' => $success);
            $json = json_encode($login_result);
            echo $json;
        }
    }
    return $success;
}

/*用户注册*/
function register($name, $pwd)
{
    global $conn;
    global $mysql_table;

    if ($conn) {
        //数据库查询
        $result = mysqli_query($conn, "select name from $mysql_table");
        $exist = false;
        while ($row = mysqli_fetch_array($result)) {
            if ($name == $row['name']) {
                //注册失败，用户名已存在;
                $exist = true;
                $register_result = array("register_result" => false, "error_code" => 0);
                $json = json_encode($register_result);
                echo $json;
            }
        }

        //插入数据库			
        if (!$exist) {
            $id = mysqli_num_rows($result) + 1;
            $success = mysqli_query($conn, "insert into $mysql_table values('$id', '$name', '$pwd')");
            if ($success) {
                //注册成功
                $register_result = array("register_result" => $success);
                $json = json_encode($register_result);
                echo $json;
            } else {
                //注册失败，数据库插入错误
                $register_result = array("register_result" => $success, "error_code" => 1);
                $json = json_encode($register_result);
                echo $json;
            }
        }
    }
}

/*修改登录密码*/
function modifypwd($name, $pwd)
{
    $newpwd = $_POST['newpwd'];
    global $conn;
    global $mysql_table;

    if ($conn) {
        //用户登录
        $login_result = login($name, $pwd, false);
        //修改密码
        if ($login_result) {
            $success = mysqli_query($conn, "update $mysql_table set pwd='$newpwd' where name='$name'");
            if ($success) {
                //修改成功
                $modify_result = array("modify_result" => $success);
                $json = json_encode($modify_result);
                echo $json;
            } else {
                //修改失败，数据库错误
                $modify_result = array("modify_result" => $success, "error_code" => 1);
                $json = json_encode($modify_result);
                echo $json;
            }
        } else {
            //修改失败，登录失败
            $modify_result = array("modify_result" => false, "error_code" => 2);
            $json = json_encode($modify_result);
            echo $json;
        }
    }
}

//显示所有用户
function showAll()
{
    global $conn;
    global $mysql_table;
    if ($conn) {
        $result = mysqli_query($conn, "select * from $mysql_table");
        $success = false;
        $array_data = array();

        $total = mysqli_num_rows($result);
        //$data = array("total"=>$total,"datas"=>array(array("data"=>"123","name"=>"zhugeheng"),
        //																					 array("data"=>"456","name"=>"zhaodanni")
        //																		));

        while ($row = mysqli_fetch_array($result)) {
            $array_temp = array("name" => $row['name']);
            array_push($array_data, $array_temp);
        }
        $data = array("total" => $total, "datas" => $array_data, "result" => true);
        $json = json_encode($data);
        echo $json;
    }
}

//关闭连接
function close_conn()
{
    global $conn;
    mysqli_close($conn);
}
