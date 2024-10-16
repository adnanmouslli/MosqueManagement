import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth/LoginController.dart';
import 'RegisterScreen.dart';

class LoginScreen extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // استخدام لون خلفية مختلف أو إضافة Gradient لجعل الواجهة جذابة
      backgroundColor: Colors.blue.shade50,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // إضافة حقل يحتوي على أيقونة واسم الصفحة في الأعلى
                Container(
                  margin: EdgeInsets.only(top: 50, bottom: 20),
                  child: Column(
                    children: [
                      // إضافة أيقونة تعبر عن تسجيل الدخول
                      Icon(
                        Icons.login_rounded, // أيقونة تسجيل الدخول
                        size: 80,
                        color: Colors.blue.shade700,
                      ),
                      SizedBox(height: 16),
                      // العنوان الرئيسي للواجهة
                      Text(
                        'تسجيل الدخول',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
                Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // حقل البريد الإلكتروني
                      TextFormField(
                        controller: controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'البريد الإلكتروني',
                          prefixIcon: Icon(Icons.email_outlined), // أيقونة البريد الإلكتروني
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء إدخال البريد الإلكتروني';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      // حقل كلمة المرور
                      TextFormField(
                        controller: controller.passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'كلمة المرور',
                          prefixIcon: Icon(Icons.lock_outline), // أيقونة كلمة المرور
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء إدخال كلمة المرور';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 24),
                      // زر تسجيل الدخول
                      Obx(() => ElevatedButton(
                        onPressed: controller.isLoading.value
                            ? null
                            : () {
                          if (controller.formKey.currentState!.validate()) {
                            controller.login();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: Colors.blue.shade700, // لون الزر
                        ),
                        child: controller.isLoading.value
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text(
                          'تسجيل الدخول',
                          style: TextStyle(fontSize: 18 , color: Colors.white),
                        ),
                      )),
                      SizedBox(height: 16),
                      // رابط للانتقال إلى واجهة تسجيل الحساب الجديد
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('ليس لديك حساب؟'),
                          TextButton(
                            onPressed: () {
                              Get.to(RegisterScreen());
                            },
                            child: Text(
                              'سجل الآن',
                              style: TextStyle(
                                color: Colors.blue.shade700,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
