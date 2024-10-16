import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PointsController extends GetxController {
  var users = <Map<String, dynamic>>[].obs; // قائمة مستخدمين قابلة للمراقبة

  @override
  void onInit() {
    super.onInit();
    fetchUsers(); // جلب المستخدمين عند التهيئة
  }

  void fetchUsers() async {
    FirebaseFirestore.instance.collection('users').snapshots().listen((event) {
      users.clear(); // تفريغ القائمة قبل إعادة التعبئة
      for (var doc in event.docs) {
        users.add({
          'username': doc['username'],
          'profileImage': doc['profileImage'],
          'points': doc['points'],
        });
      }
      users.sort((a, b) => b['points'].compareTo(a['points'])); // ترتيب حسب النقاط
    });
  }
}
