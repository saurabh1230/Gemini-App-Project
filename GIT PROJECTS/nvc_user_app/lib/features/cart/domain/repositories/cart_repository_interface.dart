import 'package:nvc_user/common/models/online_cart_model.dart';
import 'package:nvc_user/features/cart/domain/models/cart_model.dart';
import 'package:nvc_user/interface/repository_interface.dart';

abstract class CartRepositoryInterface<OnlineCart> extends RepositoryInterface<OnlineCart> {
  Future<List<OnlineCartModel>> addMultipleCartItemOnline(List<OnlineCart> carts);
  void addToSharedPrefCartList(List<CartModel> cartProductList);
  Future<bool> clearCartOnline(String? guestId);
  Future<bool> updateCartQuantityOnline(int cartId, double price, int quantity, String? guestId);
  Future<List<OnlineCartModel>> addToCartOnline(OnlineCart cart, String? guestId);
  @override
  Future<bool> delete(int? id, {String? guestId});
}