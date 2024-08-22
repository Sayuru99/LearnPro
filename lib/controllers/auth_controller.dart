import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:learnpro/screens/auth/auth_screen.dart';
import 'package:learnpro/screens/home.dart';
import 'package:learnpro/screens/utils/api_endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class AuthController extends GetxController {
  var isLogin = true.obs;
  var userRole = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserRole();
  }

  Future<void> _loadUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    String? role = prefs.getString('role');
    if (role != null) {
      userRole.value = role;
      isLogin.value = true;
    } else {
      isLogin.value = false;
    }
  }

  void toggleAuthMode() {
    isLogin.value = !isLogin.value;
    update();
  }

  Future<bool> validateToken(String token) async {
    try {
      var headers = {'Authorization': 'Bearer $token'};
      var url =
          Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.authUser);
      var response = await http.get(url, headers: headers);

      return response.statusCode == 200;
    } catch (e) {
      // print('Token validation er $e');
      return false;
    }
  }

  Future<void> checkToken() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? role = prefs.getString('role');

    if (token != null && role != null) {
      bool hasInternet = await _checkInternetConnection();
      if (hasInternet) {
        bool isValid = await validateToken(token);
        if (isValid) {
          Get.offAll(() => HomeScreen());
        } else {
          await prefs.clear();
          Get.offAll(() => AuthScreen());
        }
      } else {
        Get.offAll(() => HomeScreen());
      }
    } else {
      Get.offAll(() => AuthScreen());
    }
  }

  Future<void> logout() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token != null) {
        var headers = {
          'Authorization': 'Bearer $token',
          'content-type': 'application/json'
        };
        var url = Uri.parse(
            ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.logoutUser);

        http.Response response = await http.post(url, headers: headers);

        if (response.statusCode == 200) {
          await prefs.clear();
          userRole.value = '';
          Get.offAll(() => AuthScreen());
        } else {
          throw 'Logout failed';
        }
      } else {
        await prefs.clear();
        userRole.value = '';
        Get.offAll(() => AuthScreen());
      }
    } catch (e) {
      // print(e);
      Get.snackbar('Logout Error', e.toString());
    }
  }
}

//if htere is no internet we must check user token and role from local storage and show home
Future<bool> _checkInternetConnection() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  return connectivityResult != ConnectivityResult.none;
}
