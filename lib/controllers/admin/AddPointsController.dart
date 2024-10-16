import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddPointsController extends GetxController {
  // المتغيرات
  var selectedUser = ''.obs;
  var selectedActivity = ''.obs;
  var selectedActivityPoints = 0.obs;
  var users = [].obs;
  var activities = [].obs;

  var isLoading = false.obs; // لتحميل البيانات
  var isProcessing = false.obs; // لإدارة عملية إضافة النقاط

  // جلب المستخدمين من Firestore
  @override
  void onInit() {
    super.onInit();
    fetchUsers();
    fetchActivities();
  }

  void fetchUsers() async {
    try {
      var snapshot = await FirebaseFirestore.instance.collection('users').get();
      users.value = snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'name': doc['username'],
          'points': doc['points'], // يمكن استخدامه لاحقًا لجلب نقاط المستخدم
        };
      }).toList();
    } catch (e) {
      Get.snackbar('خطأ', 'حدث خطأ أثناء جلب المستخدمين: $e');
    }
  }

  // جلب النشاطات من Firestore
  void fetchActivities() async {
    try {
      var snapshot = await FirebaseFirestore.instance.collection('activities').get();
      activities.value = snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'name': doc['activityName'],
          'points': doc['points'], // النقاط المستحقة للنشاط
        };
      }).toList();
    } catch (e) {
      Get.snackbar('خطأ', 'حدث خطأ أثناء جلب النشاطات: $e');
    }
  }

  // جلب النقاط المستحقة للنشاط المختار
  void fetchActivityPoints() {
    var activity = activities.firstWhere((activity) => activity['id'] == selectedActivity.value);
    selectedActivityPoints.value = activity['points'];
  }

  // إضافة النقاط للمستخدم
  void addPointsToUser() async {
    if (selectedUser.value.isNotEmpty && selectedActivity.value.isNotEmpty) {
      isProcessing.value = true; // تعيين الحالة إلى معالجة
      try {
        // جلب بيانات المستخدم
        var userDoc = await FirebaseFirestore.instance.collection('users').doc(selectedUser.value).get();
        int currentPoints = userDoc['points'] ?? 0;

        // حساب النقاط الجديدة
        int newPoints = currentPoints + selectedActivityPoints.value;

        // تحديث نقاط المستخدم
        await FirebaseFirestore.instance.collection('users').doc(selectedUser.value).update({
          'points': newPoints,
        });

        Get.snackbar('نجاح', 'تم إضافة النقاط بنجاح');
      } catch (e) {
        Get.snackbar('خطأ', 'حدث خطأ أثناء إضافة النقاط: $e');
      } finally {
        isProcessing.value = false; // إيقاف حالة المعالجة
      }
    } else {
      Get.snackbar('خطأ', 'يرجى اختيار المستخدم والنشاط');
    }
  }

  // حذف النقاط من المستخدم
  void removePointsFromUser() async {
    if (selectedUser.value.isNotEmpty && selectedActivity.value.isNotEmpty) {
      isProcessing.value = true; // تعيين الحالة إلى معالجة
      try {
        // جلب بيانات المستخدم
        var userDoc = await FirebaseFirestore.instance.collection('users').doc(selectedUser.value).get();
        int currentPoints = userDoc['points'] ?? 0;

        // التحقق من وجود نقاط كافية للحذف
        if (currentPoints >= selectedActivityPoints.value) {
          // حساب النقاط الجديدة
          int newPoints = currentPoints - selectedActivityPoints.value;

          // تحديث نقاط المستخدم
          await FirebaseFirestore.instance.collection('users').doc(selectedUser.value).update({
            'points': newPoints,
          });

          Get.snackbar('نجاح', 'تم حذف النقاط بنجاح');
        } else {
          Get.snackbar('خطأ', 'لا يوجد نقاط كافية للحذف');
        }
      } catch (e) {
        Get.snackbar('خطأ', 'حدث خطأ أثناء حذف النقاط: $e');
      } finally {
        isProcessing.value = false; // إيقاف حالة المعالجة
      }
    } else {
      Get.snackbar('خطأ', 'يرجى اختيار المستخدم والنشاط');
    }
  }
}
