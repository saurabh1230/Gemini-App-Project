import 'package:nvc_user/features/cuisine/domain/models/cuisine_restaurants_model.dart';
import 'package:nvc_user/interface/repository_interface.dart';

abstract class CuisineRepositoryInterface extends RepositoryInterface{
  Future<CuisineRestaurantModel?> getRestaurantList(int offset, int cuisineId);
}