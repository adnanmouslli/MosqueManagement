import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

void showCustomSnackbar(String title, String message, bool isSuccess) {
  Get.snackbar(
    title,
    message,
    backgroundColor: isSuccess ? Colors.green : Colors.red, // اللون حسب النجاح أو الخطأ
    colorText: Colors.white, // لون النص
    snackPosition: SnackPosition.BOTTOM, // عرض الإشعار من الأسفل
    margin: const EdgeInsets.all(10), // هوامش للإشعار
    borderRadius: 10, // تدوير الحواف
    animationDuration: const Duration(milliseconds: 500), // مدة الرسوم المتحركة للإشعار
    duration: const Duration(seconds: 3), // مدة بقاء الإشعار
    icon: Icon(
      isSuccess ? Icons.check_circle_outline : Icons.error_outline, // أيقونة حسب النجاح أو الخطأ
      color: Colors.white,
      size: 35,
    ),
    shouldIconPulse: true, // تفعيل نبض الأيقونة
    boxShadows: [
      BoxShadow(
        color: Colors.black.withOpacity(0.3),
        blurRadius: 10,
        offset: const Offset(0, 4),
      ),
    ],
    padding: const EdgeInsets.all(16), // إضافة مساحة داخل الإشعار
    isDismissible: true, // إمكانية الإزالة بالسحب
    dismissDirection: DismissDirection.horizontal, // إمكانية سحب الإشعار لإزالته
  );
}
