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
$email = isset($_POST['email']) ? $_POST['email'] : '';
$name = isset($_POST['name']) ? $_POST['name'] : '';
$pwd = isset($_POST['pwd']) ? $_POST['pwd'] : '';

if ($action == 'login') {
    login($email, $pwd);
} else if ($action == 'register') {
    register($email, $name, $pwd);
} else if ($action == 'modifypwd') {
    modifypwd($email, $pwd);
} else if ($action == 'showAll') {
    showAll();
} else {
    $result = array("result" => "error_request");
    $json = json_encode($result);
    echo $json;
}

close_conn();

/*用户登录*/
function login($email, $pwd)
{
    global $conn;
    global $mysql_table;

    if ($conn) {
        $result = mysqli_query($conn, "select email,pwd from $mysql_table");
        $success = false;
        while ($row = mysqli_fetch_array($result)) {
            if ($email == $row['email'] && $pwd == $row['pwd']) {
                $success = true;
            }
        }
        $message = "登录失败";
        if ($success) {
            $message = "登录成功";
        }
        echo json_encode([
            "success" => $success,
            "message" => $message
        ]);
    } else {
        echo json_encode([
            "success" => false,
            "message" => "服务器出错"
        ]);
    }
}

/*用户注册*/
function register($email, $name, $pwd)
{
    global $conn;
    global $mysql_table;

    $success = false;

    if ($conn) {
        //数据库查询
        $result = mysqli_query($conn, "select email from $mysql_table");
        $exist = false;
        while ($row = mysqli_fetch_array($result)) {
            if ($email == $row['email']) {
                //注册失败，邮箱已存在;
                $exist = true;
            }
        }

        //插入数据库			
        if (!$exist) {
            $id = mysqli_num_rows($result) + 1;
            $success = mysqli_query($conn, "insert into $mysql_table values('$id', '$name', '$pwd', '$email')");
        }

        $message = "注册成功";
        if (!$success) {
            if ($exist) {
                $message = "邮箱已存在";
            } else {
                $message = "注册失败";
            }
        }
        echo json_encode([
            "success" => $success,
            "message" => $message
        ]);
    } else {
        echo json_encode([
            "success" => false,
            "message" => "服务器出错"
        ]);
    }
}

/*修改登录密码*/
function modifypwd($email, $pwd)
{
    $newpwd = $_POST['newpwd'];
    global $conn;
    global $mysql_table;

    if ($conn) {
        //用户登录
        $login_result = login($email, $pwd, false);
        //修改密码
        if ($login_result) {
            $success = mysqli_query($conn, "update $mysql_table set pwd='$newpwd' where email='$email'");
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
            $array_temp = array("name" => $row['name'], "email" => $row['email']);
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
