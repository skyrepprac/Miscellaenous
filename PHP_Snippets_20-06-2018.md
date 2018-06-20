<?php
$array1 = [['id' => '1', 'name' => 'Coach/Bus'],['id' => '2', 'name' => 'Truck'],['id' => '3', 'name' => 'Urban'],['id' => '4', 'name' => 'RV'],['id' => '3,4', 'name' => 'Urban,RV']];
print_r($array1);
simplifyUniqueArray($array1);
function simplifyUniqueArray($array) {
    $arrayTempIds = $arrayTempNames = $arrayFinal = [];
    foreach ($array as $key => $value) {
        if (strpos($value['id'], ',') !== false || strpos($value['name'], ',') !== false) {
            foreach (explode($value['id'], ',') as $val) {
                $arrayTempIds[] = $val;
            }
            foreach (explode($value['name'], ',') as $val) {
                $arrayTempNames[] = $val;
            }
        } else {
            $arrayTempIds[] = $value['id'];
            $arrayTempNames[] = $value['name'];
        }
    }
    $arrayTempNames = array_filter(preg_replace('/[ ,]+/', '', $arrayTempNames));
    $arrayTempIds = array_filter(preg_replace('/[ ,]+/', '', $arrayTempIds));
    $iterator = 0;
    foreach ($arrayTempIds as $id) {
        $arrayFinal[$iterator]['id'] = $id;
        $arrayFinal[$iterator]['name'] = $arrayTempNames[$iterator];
        $iterator++;
    }
    print_r($arrayFinal);exit;
}
?>
