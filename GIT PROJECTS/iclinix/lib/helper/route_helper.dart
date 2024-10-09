
import 'package:get/get.dart';
import 'package:iclinix/app/screens/appointment/booking_successful_screen.dart';
import 'package:iclinix/app/screens/appointment/patient_details_screen.dart';
import 'package:iclinix/app/screens/appointment/payment_screen.dart';
import 'package:iclinix/app/screens/appointment/select_slot_screen.dart';
import 'package:iclinix/app/screens/auth/lets_begin_screen.dart';
import 'package:iclinix/app/screens/auth/login_screen.dart';
import 'package:iclinix/app/screens/auth/otp_verification_screen.dart';
import 'package:iclinix/app/screens/auth/register_screen.dart';
import 'package:iclinix/app/screens/dashboard/dashboard_screen.dart';
import 'package:iclinix/app/screens/onboard/splash.dart';


class RouteHelper {
  static const String initial = '/';
  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  static const String otpVerification = '/otp-verification';
  static const String letsBegin = '/lets-begin';
  static const String dashboard = '/dashboard';
  static const String selectSlot = '/select-slot';
  static const String patientDetails = '/patient-details';
  static const String paymentMethod = '/payment-method';
  static const String bookingSuccessful = '/payment-successful';




  /// Routes ==================>
  static String getInitialRoute() => initial;
  static String getSplashRoute() => splash;
  static String getLoginRoute() => login;
  static String getRegisterRoute() => register;
  static String getOtpVerificationRoute(String? phoneNo,) => '$otpVerification?phoneNo=$phoneNo';
  static String getLetsBeginRoute() => letsBegin;
  static String getDashboardRoute() => dashboard;
  static String getSelectSlotRoute() => selectSlot;
  static String getAddPatientDetailsRoute() => patientDetails;
  static String getPaymentMethodRoute() => paymentMethod;
  static String getBookingSuccessfulRoute() => bookingSuccessful;



  /// Pages ==================>
  static List<GetPage> routes = [
    GetPage(name: initial, page: () => const SplashScreen()),
    GetPage(name: login, page: () =>  LoginScreen()),
    GetPage(name: register, page: () =>  RegisterScreen()),
    GetPage(name: otpVerification, page: () =>  OtpVerificationScreen(phoneNo :Get.parameters['phoneNo'])),
    GetPage(name: dashboard, page: () =>  const DashboardScreen(pageIndex: 0)),
    GetPage(name: selectSlot, page: () =>  SelectSlotScreen()),
    GetPage(name: letsBegin, page: () =>  LetsBeginScreen()),
    GetPage(name: patientDetails, page: () =>  PatientDetailsScreen()),
    GetPage(name: paymentMethod, page: () =>  PaymentScreen()),
    GetPage(name: bookingSuccessful, page: () =>  BookingSuccessfulScreen()),



  ];
}