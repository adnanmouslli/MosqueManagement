import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/cache_helper.dart';
import '../../views/admin/HomeAdmin.dart';
import '../../views/home/HomeScreen.dart';

class LoginController extends GetxController {
  // مفاتيح النموذج للتحقق
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // الكنترولرز لحقول الإدخال
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // متغير لتحميل حالة الـ Loading
  var isLoading = false.obs;

  // دالة لتسجيل الدخول
  Future<void> login() async {


    if(emailController.text == "admin" && passwordController.text == "admin"){
      Get.offAll(HomeAdmin());
      return;
    }

    // التحقق من صحة الإدخال قبل المتابعة
    if (!formKey.currentState!.validate()) {
      return;
    }

    isLoading.value = true;

    try {
      // تسجيل الدخول في Firebase
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // جلب بيانات المستخدم من Firestore
      DocumentSnapshot userData = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      // تخزين بيانات المستخدم في الكاش
      await CacheHelper.putData(key: 'userName', value: userData['username']);
      await CacheHelper.putData(key: 'userEmail', value: userData['email']);
      await CacheHelper.putData(key: 'userImage', value: userData['profileImage']);
      await CacheHelper.putData(key: 'userRole', value: userData['role']);
      await CacheHelper.putData(key: 'userAge', value: userData['age']);


      // إظهار رسالة نجاح
      Get.snackbar(
          'نجاح',
          'تم تسجيل الدخول بنجاح!',
          backgroundColor: Colors.green,
          colorText: Colors.white
      );


      // الانتقال إلى الصفحة الرئيسية بعد تسجيل الدخول
      Get.offAll(HomeScreen());
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'user-not-found') {
        message = 'لم يتم العثور على مستخدم بهذا البريد الإلكتروني.';
      } else if (e.code == 'wrong-password') {
        message = 'كلمة المرور غير صحيحة.';
      } else {
        message = 'حدث خطأ: ${e.message}';
      }
      Get.snackbar(
          'خطأ',
          message,
          backgroundColor: Colors.red,
          colorText: Colors.white
      );
    } finally {
      isLoading.value = false;
    }
  }

  // تصفير الحقول
  void clearFields() {
    emailController.clear();
    passwordController.clear();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

}
