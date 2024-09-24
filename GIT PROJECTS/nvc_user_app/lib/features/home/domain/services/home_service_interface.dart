import 'package:nvc_user/features/home/domain/models/banner_model.dart';

abstract class HomeServiceInterface {
  Future<BannerModel?> getBannerList();
}