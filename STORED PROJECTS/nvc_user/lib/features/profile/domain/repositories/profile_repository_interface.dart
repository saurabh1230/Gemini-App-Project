import 'package:nvc_user/common/models/response_model.dart';
import 'package:nvc_user/features/profile/domain/models/userinfo_model.dart';
import 'package:nvc_user/interface/repository_interface.dart';
import 'package:image_picker/image_picker.dart';

abstract class ProfileRepositoryInterface extends RepositoryInterface {
  Future<ResponseModel> updateProfile(UserInfoModel userInfoModel, XFile? data, String token);
  Future<ResponseModel> changePassword(UserInfoModel userInfoModel);
}