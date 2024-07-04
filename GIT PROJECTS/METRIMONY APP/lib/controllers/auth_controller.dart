


import 'package:bureau_couple/src/models/profie_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:bureau_couple/data/repository/repo/auth_repo.dart';
import 'package:bureau_couple/features/widgets/custom_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helper/route_helper.dart';
import '../utils/app_constants.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  final SharedPreferences sharedPreferences;
  AuthController({required this.authRepo,required this.sharedPreferences, }) ;


  int? _userId;
  int? get userId => _userId;

  String? firstNameString;String? lastNameString;

  XFile? _pickedImage;
  XFile? get pickedImage => _pickedImage;
  XFile? _pickedCover;
  XFile? get pickedCover => _pickedCover;
  void pickImage(bool isLogo, bool isRemove) async {
    if(isRemove) {
      _pickedImage = null;
      _pickedCover = null;
    }else {
      if (isLogo) {
        _pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      } else {
        _pickedCover = await ImagePicker().pickImage(source: ImageSource.gallery);
      }
      update();
    }
  }

  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  Future<void> saveUserIdToPrefs(String userId) async {
    try {
      await sharedPreferences.setString(AppConstants.userId, userId);
      print('User ID saved to SharedPreferences: $userId');
    } catch (e) {
      print('Error saving User ID to SharedPreferences: $e');
    }
  }

  Future<String?> getUserIdFromPrefs() async {
    try {
      String? userId = sharedPreferences.getString(AppConstants.userId);
      print('User ID retrieved from SharedPreferences: $userId');
      return userId;
    } catch (e) {
      print('Error retrieving User ID from SharedPreferences: $e');
      return null;
    }
  }





  bool isFirstTime = true;
  bool _showPassView = false;
  bool _lengthCheck = false;
  bool _numberCheck = false;
  bool _uppercaseCheck = false;
  bool _lowercaseCheck = false;
  bool _spatialCheck = false;




  List<dynamic>? _additionalList;
  bool _isLoading = false;
  bool get isLoading => _isLoading;






  bool get showPassView => _showPassView;
  bool get lengthCheck => _lengthCheck;
  bool get numberCheck => _numberCheck;
  bool get uppercaseCheck => _uppercaseCheck;
  bool get lowercaseCheck => _lowercaseCheck;

  List<dynamic>? get additionalList => _additionalList;




  Future<void> loginApi(username, password,) async {
    _isLoading = true;
    update();
    Response response = await authRepo.login(username, password);
    var responseData = response.body;
    if(responseData['status'] == "success") {
      _isLoading = false;
      update();
      showCustomSnackBar("Login Success",isError: false);
      authRepo.saveUserToken(responseData['data']['access_token']);
      Get.offAllNamed(RouteHelper.getDashboardRoute());
    } else {
      showCustomSnackBar("Login Failed Please Check Credentials",isError: false);
    }
    _isLoading = false;
    update();
  }


}
