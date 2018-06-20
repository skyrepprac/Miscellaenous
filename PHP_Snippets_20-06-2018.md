```php
<?php
$array1 = [['id' => '1', 'name' => 'Name1'],['id' => '2', 'name' => 'Name2'],['id' => '3', 'name' => 'Name3'],['id' => '4', 'name' => 'Name4'],['id' => '3,4', 'name' => 'Name3,Name4']];
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
```
