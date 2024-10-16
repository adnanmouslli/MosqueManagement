import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../utils/cache_helper.dart';

class ActivityController extends GetxController {
  // التحكم في حقول الإدخال
  TextEditingController activityNameController = TextEditingController();
  TextEditingController pointsController = TextEditingController();


  // متغيرات تفاعلية لتخزين النشاطات
  var activities = [].obs;


  var userEmail = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchActivities(); // استدعاء لجلب النشاطات عند تهيئة الكونترولر

    userEmail.value = CacheHelper.getData(key: 'userEmail') ?? '0';

  }


  // ميثود لإضافة نشاط إلى Firebase
  Future<void> addActivity() async {
    String activityName = activityNameController.text;
    String points = pointsController.text;

    if (activityName.isEmpty || points.isEmpty) {
      Get.snackbar(
        'خطأ',
        'يرجى إدخال اسم النشاط وعدد النقاط المستحقة',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      // حفظ البيانات في Firebase
      await FirebaseFirestore.instance.collection('activities').add({
        'activityName': activityName,
        'points': int.parse(points),  // تحويل النقاط إلى عدد صحيح
        'createdAt': Timestamp.now(), // إضافة توقيت الإنشاء
      });

      // إظهار رسالة نجاح
      Get.snackbar(
        'نجاح',
        'تم إضافة النشاط بنجاح!',
        snackPosition: SnackPosition.BOTTOM,
      );

      // إعادة تعيين الحقول
      activityNameController.clear();
      pointsController.clear();
    } catch (e) {
      // إظهار رسالة خطأ في حالة حدوث مشكلة
      Get.snackbar(
        'خطأ',
        'حدث خطأ أثناء إضافة النشاط: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }


  void fetchActivities() async {
    try {
      FirebaseFirestore.instance
          .collection('activities')
          .orderBy('points', descending: true) // ترتيب النشاطات بناءً على النقاط
          .snapshots()
          .listen((snapshot) {
        activities.value = snapshot.docs.map((doc) {
          return {
            'docId': doc.id,
            'name': doc['activityName'],
            'points': doc['points'],
          };
        }).toList();
      });
    } catch (e) {
      Get.snackbar('خطأ', 'حدث خطأ أثناء جلب النشاطات: $e');
    }
  }


  // ميثود لحذف النشاط من Firestore
  void deleteActivity(String id) async {
    try {
      await FirebaseFirestore.instance.collection('activities').doc(id).delete();
      Get.snackbar('تم الحذف', 'تم حذف النشاط بنجاح');
    } catch (e) {
      Get.snackbar('خطأ', 'حدث خطأ أثناء حذف النشاط: $e');
    }
  }


  @override
  void dispose() {
    // TODO: implement dispose
    activityNameController.dispose();
    pointsController.dispose();
    super.dispose();
  }
}
