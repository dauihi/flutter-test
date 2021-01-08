<?php

$a = $_POST['a'];
$b = $_POST['b'];

if (is_null($a) || is_null($b)) {
    echo json_encode(array(
        'code' => 400,
        'message' => 'a或b 不能为空',
    ));
    return;
}
$c = $a + $b;
echo  json_encode(array(
    'code' => 200,
    'message' => 'ok',
    'data' => $c
));
