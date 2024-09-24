import 'package:nvc_user/common/models/product_model.dart';
import 'package:nvc_user/interface/repository_interface.dart';

abstract class ProductRepositoryInterface implements RepositoryInterface {

  @override
  Future<List<Product>?> getList({int? offset, String? type});
}