<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);
set_time_limit(0);
ini_set('memory_limit','1024M');

require_once 'app/Mage.php';
Mage::app();
Mage::app()->getStore()->setId(Mage_Core_Model_App::ADMIN_STORE_ID);

$importDir = Mage::getBaseDir('media') . DS . 'newProductImages/';
$prodImagesData = array(
				'Prod_Image_Name.jpg',
				'Prod_Image_Name.jpg',
				'Prod_Image_Name.jpg',
				'Prod_Image_Name.jpg'
				);

$productSKU = '[Product_Sku]';
$ourProduct = Mage::getModel('catalog/product')->loadByAttribute('sku',$productSKU);
foreach($prodImagesData as $fileName) {
	$filePath = $importDir.$fileName;
	if (file_exists($filePath)) {
		$ourProduct->addImageToMediaGallery($filePath, array('image', 'small_image', 'thumbnail'), false, false);
		$ourProduct->save();
		echo "<pre/>Product Images uploaded successfully";
	} else {
		echo "<pre/>" . $productSKU . " image upload failed !!!";
	}
}
