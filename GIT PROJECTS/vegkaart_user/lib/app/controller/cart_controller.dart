import 'package:vegkaart_customer/app/controller/home_controller.dart';
import 'package:vegkaart_customer/services/localDatabase.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  RxList<CartProduct> cartProducts = <CartProduct>[].obs;
  HomeController homeController = Get.find<HomeController>();


}
