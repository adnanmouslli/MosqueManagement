import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mypoints/views/auth/LoginScreen.dart';

import '../../utils/functions/showCustomSnackbar.dart';

class RegisterController extends GetxController {
  // مفاتيح النموذج للتحقق
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // الكنترولرز لحقول الإدخال
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  // متغير لتخزين الصفة الدراسية المختارة
  var selectedRole = ''.obs;

  // متغير لتحميل حالة الـ Loading
  var isLoading = false.obs;
  // متغير لتخزين مسار الصورة
  var profileImageUrl = ''.obs;
  // متغير لتخزين الصورة المختارة
  XFile? selectedImage;

  // مرجع FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // مرجع Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // دالة لاختيار الصورة
  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    selectedImage = await _picker.pickImage(source: ImageSource.gallery);

    if (selectedImage != null) {
      isLoading.value = true;
      try {
        await uploadImage();
      } catch (e) {
        showCustomSnackbar('خطأ', 'حدث خطأ غير متوقع: $e', true);

      } finally {
        isLoading.value = false;

      }
      showCustomSnackbar('نجاح', 'تم اختيار الصورة بنجاح.', true);

    }

    update();
  }

  // دالة التسجيل
  Future<void> register() async {
    isLoading.value = true;

    if (selectedImage == null) {
      showCustomSnackbar('خطأ', "يرجى اختيار صورة شخصية وذلك بالنقر على الايقونة بالاعلى", false);
      isLoading.value = false;
      return;
    }

    try {
      // إنشاء حساب جديد في Firebase
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // بعد نجاح التسجيل، تحديث بيانات المستخدم مثل اسم المستخدم
      await userCredential.user!.updateDisplayName(usernameController.text);

      // // رفع الصورة إذا تم اختيار صورة
      // if (selectedImage != null) {
      //   await uploadImage(userCredential.user!.uid);
      // }

      // حفظ بيانات المستخدم الإضافية في Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'username': usernameController.text,
        'email': emailController.text,
        'age': int.parse(ageController.text), // تحويل العمر إلى رقم
        'role': selectedRole.value, // الصفة الدراسية المختارة
        'profileImage': profileImageUrl.value, // حفظ رابط الصورة
        'createdAt': FieldValue.serverTimestamp(),
      });

      // إظهار رسالة نجاح
      showCustomSnackbar('نجاح', 'تم إنشاء الحساب بنجاح!', true);

      // تصفير الحقول
      clearFields();
      Get.offAll(LoginScreen());

    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'weak-password') {
        message = 'كلمة المرور ضعيفة جداً.';
      } else if (e.code == 'email-already-in-use') {
        message = 'البريد الإلكتروني مستخدم بالفعل.';
      } else {
        message = 'حدث خطأ: ${e.message}';
      }
      showCustomSnackbar('خطأ', message, false);

    } catch (e) {
      showCustomSnackbar('خطأ', 'حدث خطأ غير متوقع: $e', false);

    } finally {
      isLoading.value = false;
    }
  }

  // دالة لرفع الصورة بعد التسجيل
  Future<void> uploadImage() async {
    final String fileName = DateTime.now().millisecondsSinceEpoch.toString() + '.png';
    final Reference storageRef = FirebaseStorage.instance.ref().child('profile_images/$fileName');

    try {
      await storageRef.putFile(File(selectedImage!.path));
      profileImageUrl.value = await storageRef.getDownloadURL();
    } catch (e) {
      showCustomSnackbar('خطأ', 'حدث خطأ أثناء رفع الصورة: $e', false);

    }
  }

  // دالة لتصفير الحقول
  void clearFields() {
    usernameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    ageController.clear();
    selectedRole.value = '';
    profileImageUrl.value = '';
    selectedImage = null;
  }

  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    ageController.dispose();
    super.onClose();
  }
}
