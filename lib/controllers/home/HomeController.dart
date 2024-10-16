import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mypoints/utils/cache_helper.dart';
import 'package:mypoints/views/auth/LoginScreen.dart';

class HomeController extends GetxController {
  // بيانات المستخدم
  var userName = ''.obs;
  var userEmail = ''.obs;
  var userImage = ''.obs;
  var userRole = ''.obs;
  var userAge = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // جلب بيانات المستخدم من الكاش
    userName.value = CacheHelper.getData(key: 'userName') ?? 'غير معروف';
    userEmail.value = CacheHelper.getData(key: 'userEmail') ?? 'غير معروف';
    userImage.value = CacheHelper.getData(key: 'userImage') ?? '';
    userRole.value = CacheHelper.getData(key: 'userRole') ?? 'غير معروف';
    userAge.value = CacheHelper.getData(key: 'userAge') ?? 'غير معروف';
  }


    Future<void> logout() async {
      try {
        await FirebaseAuth.instance.signOut(); // تسجيل الخروج من Firebase
        CacheHelper.delete(key: "userName");
        CacheHelper.delete(key: "userEmail");
        CacheHelper.delete(key: "userImage");
        CacheHelper.delete(key: "userRole");
        CacheHelper.delete(key: "userAge");

        Get.offAll(LoginScreen()); // إعادة التوجيه لصفحة تسجيل الدخول
      } catch (e) {
        Get.snackbar('خطأ', 'حدث خطأ أثناء تسجيل الخروج: $e');
      }
    }

}
