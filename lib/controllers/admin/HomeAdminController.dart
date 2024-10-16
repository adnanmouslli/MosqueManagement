import 'package:get/get.dart';
import 'package:mypoints/views/auth/LoginScreen.dart';

class HomeAdminController extends GetxController {



  @override
  void onInit() {
    super.onInit();

  }


  void logout()  {

      Get.offAll(LoginScreen());

  }

}
