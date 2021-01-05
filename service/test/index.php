<?php
$x = 20;
$count = 0;
$day = date("Ymd", strtotime(sprintf("+%d day", $count)));
echo $day;
