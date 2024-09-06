import 'package:flutter/material.dart';
import 'package:ebasket_customer/app/controller/home_controller.dart';
import 'package:ebasket_customer/app/model/attributes_model.dart';
import 'package:ebasket_customer/app/model/favourite_item_model.dart';
import 'package:ebasket_customer/app/model/item_attributes.dart';
import 'package:ebasket_customer/app/model/product_model.dart';
import 'package:ebasket_customer/services/firebase_helper.dart';
import 'package:ebasket_customer/services/localDatabase.dart';
import 'package:get/get.dart';

class ProductListController extends GetxController {
  RxBool isLoading = true.obs;

  RxList<ProductModel> productList = <ProductModel>[].obs;
  RxList<ProductModel> productSearchList = <ProductModel>[].obs;
  RxList<ProductModel> freshVegetablesList = <ProductModel>[].obs;
  RxList<ProductModel> freshFruitsList = <ProductModel>[].obs;
  RxList<ProductModel> ExoticVegetablesList = <ProductModel>[].obs;
  RxList<ProductModel> ExoticFruitsList = <ProductModel>[].obs;
  RxList<ProductModel> GreenVegetablesList = <ProductModel>[].obs;
  RxList<ProductModel> baveragesList = <ProductModel>[].obs;
  RxList<ProductModel> bakeryList = <ProductModel>[].obs;
  RxList<String> selectedBrandId = <String>[].obs;


  RxList<CartProduct> cartProducts = <CartProduct>[].obs;
  RxInt cartCount = 0.obs;
  RxString categoryId = '0'.obs;
  RxString categoryName = ''.obs;
  Rx<TextEditingController> searchTextFiledController = TextEditingController().obs;
  RxList<FavouriteItemModel> listFav = <FavouriteItemModel>[].obs;
  HomeController homeController = Get.find<HomeController>();
  RxString type = ''.obs;
  RxList<Attributes>? attributes = <Attributes>[].obs;
  RxList<Variants>? variants = <Variants>[].obs;
  RxList<String> selectedVariants = <String>[].obs;
  RxList<String> selectedIndexVariants = <String>[].obs;
  RxList<String> selectedIndexArray = <String>[].obs;
  RxList<AttributesModel> attributesList = <AttributesModel>[].obs;
  RxInt selectedVariantIndex = 0.obs;
  RxList<String> tempProduct = <String>[].obs;
  RxList<CartProduct> tempCartProducts = <CartProduct>[].obs;

  @override
  void onInit() {
    getData();
    getFavoriteData();
    fetchFreshVegetablesProducts();
    fetchFreshFruitProducts();
    fetchExoticVegetablesProducts();
    fetchExoticFruitsListProducts();
    fetchGreenVegetablesListProducts();
    fetchBaveragesListProducts();
    fetchBakeryListProducts();
    super.onInit();
  }

  getData() async {
    dynamic argumentData = Get.arguments;
    selectedVariantIndex.value = -1;
    if (argumentData['categoryId'] != null) {
      categoryId.value = argumentData['categoryId'];
      categoryName.value = argumentData['categoryName'];

      await FireStoreUtils.getProductListByCategoryId(categoryId.value).then((value) {
        if (value != null) {
          productList.value = (value);
          productSearchList.value = (value);
        }
      });
      isLoading.value = false;
    } else if (argumentData['type'] != null) {
      type.value = argumentData['type'];

      if (type.value == 'brand') {
         FireStoreUtils.getEstablishBrandProducts().then((value) {
          if (value != null) {
            for (var element in value) {
              if (element.brandID != null) {
                productList.value = value;
                productSearchList.value = value;
              }
            }
          }
        });

      } else if (type.value == 'checkoutBrand') {
        tempCartProducts.value = await homeController.cartDatabase.value.allCartProducts;
        for (int i = 0; i < tempCartProducts.length; i++) {
          tempProduct.add(tempCartProducts[i].id.toString());
        }
        // FireStoreUtils.getEstablishBrandProducts().then((value) {
        FireStoreUtils.getAllDeliveryProducts().then((value) {
          if (value != null) {
            for (var element in value) {
              if (element.brandID != null) {
                if (!tempProduct.contains('${element.id!}~')) {
                  productList.add(element);
                  productSearchList.add(element);
                  // productList.value = value;
                  // productSearchList.value = value;
                }
              }
            }
          }
        });
      } else {
        FireStoreUtils.getBestOfferProducts().then((value) {
          if (value != null) {
            productList.value = value;
            productSearchList.value = value;
          }
        });
      }

      isLoading.value = false;
    }
    await FireStoreUtils.getVendorAttribute().then((value) {
      if (value != null) {
        attributesList.value = value;
      }
      update();
    });
    update();
  }

  Future<void> fetchFreshVegetablesProducts() async {
    const String staticCategoryId = '65d85efaa0c87';
    await FireStoreUtils.getProductListByCategoryId(staticCategoryId).then((value) {
      freshVegetablesList.value = value!;
    }).catchError((error) {
      print('Error fetching products: $error');
    }).whenComplete(() {
      isLoading.value = false;
    });
  }

  Future<void> fetchFreshFruitProducts() async {
    const String staticCategoryId = '65d86088c7958'; // Static category ID
    await FireStoreUtils.getProductListByCategoryId(staticCategoryId).then((value) {
      freshFruitsList.value = value!;
    }).catchError((error) {
      print('Error fetching products: $error');
    }).whenComplete(() {
      isLoading.value = false;
    });
  }

  Future<void> fetchExoticVegetablesProducts() async {
    const String staticCategoryId = '65d860d6ea757'; // Static category ID
    await FireStoreUtils.getProductListByCategoryId(staticCategoryId).then((value) {
      ExoticVegetablesList.value = value!;
    }).catchError((error) {
      print('Error fetching products: $error');
    }).whenComplete(() {
      isLoading.value = false;
    });
  }

  Future<void> fetchExoticFruitsListProducts() async {
    const String staticCategoryId = '65e5abad2c9f7'; // Static category ID
    await FireStoreUtils.getProductListByCategoryId(staticCategoryId).then((value) {
      ExoticFruitsList.value = value!;
    }).catchError((error) {
      print('Error fetching products: $error');
    }).whenComplete(() {
      isLoading.value = false;
    });
  }

  Future<void> fetchGreenVegetablesListProducts() async {
    const String staticCategoryId = '65e5ac604f4f2'; // Static category ID
    await FireStoreUtils.getProductListByCategoryId(staticCategoryId).then((value) {
      GreenVegetablesList.value = value!;
    }).catchError((error) {
      print('Error fetching products: $error');
    }).whenComplete(() {
      isLoading.value = false;
    });
  }

  Future<void> fetchBaveragesListProducts() async {
    const String staticCategoryId = '65e5acb0ecc9e'; // Static category ID
    await FireStoreUtils.getProductListByCategoryId(staticCategoryId).then((value) {
      baveragesList.value = value!;
    }).catchError((error) {
      print('Error fetching products: $error');
    }).whenComplete(() {
      isLoading.value = false;
    });
  }

  Future<void> fetchBakeryListProducts() async {
    const String staticCategoryId = '665b313d67893'; // Static category ID
    await FireStoreUtils.getProductListByCategoryId(staticCategoryId).then((value) {
      bakeryList.value = value!;
    }).catchError((error) {
      print('Error fetching products: $error');
    }).whenComplete(() {
      isLoading.value = false;
    });
  }


  getFavoriteData() async {
    await FireStoreUtils.getFavouritesProductList(FireStoreUtils.getCurrentUid()).then((value) {
      if (value != null) {
        listFav.value = value;
      }
    });
  }

  getFilterData(String value) async {
    if (value.toString().isNotEmpty) {
      productSearchList.value = productList.where((e) => e.name!.toLowerCase().contains(value.toLowerCase().toString()) || e.name!.startsWith(value.toString())).toList();
    } else {
      productSearchList.value = productList;
    }
    update();
  }
}
