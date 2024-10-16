import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth/RegisterController.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RegisterController controller = Get.put(RegisterController());

    // قائمة الصفة الدراسية
    final List<String> roles = [
      'تاسع', 'عاشر', 'حادي عشر', 'بكلوريا', 'جامعة', 'متخرج'
    ];

    return Scaffold(

      body: Center(
        child: GetBuilder<RegisterController>(
          builder: (controller) => Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Obx(() {
                    return Form(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // أيقونة كبيرة تمثل المستخدم
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                controller.pickImage();
                              },
                              child: CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.blue[100],
                                backgroundImage: controller.profileImageUrl.value.isNotEmpty
                                    ? NetworkImage(controller.profileImageUrl.value) // استخدام الصورة التي تم رفعها
                                    : null,
                                child: controller.profileImageUrl.value.isEmpty
                                    ? Icon(
                                  Icons.photo_filter_outlined,
                                  size: 80,
                                  color: Colors.blue,
                                )
                                    : null,
                              ),
                            ),
                          ),
                          SizedBox(height: 30),

                          // حقل اسم المستخدم مع أيقونة
                          TextFormField(
                            controller: controller.usernameController,
                            decoration: InputDecoration(
                              labelText: 'اسم المستخدم',
                              prefixIcon: Icon(Icons.person_outline), // إضافة أيقونة صغيرة
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'الرجاء إدخال اسم المستخدم';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),

                          // حقل البريد الإلكتروني مع أيقونة
                          TextFormField(
                            controller: controller.emailController,
                            decoration: InputDecoration(
                              labelText: 'البريد الإلكتروني',
                              prefixIcon: Icon(Icons.email_outlined), // إضافة أيقونة صغيرة
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || !value.contains('@')) {
                                return 'الرجاء إدخال بريد إلكتروني صالح';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),

                          // حقل كلمة المرور مع أيقونة
                          TextFormField(
                            controller: controller.passwordController,
                            decoration: InputDecoration(
                              labelText: 'كلمة المرور',
                              prefixIcon: Icon(Icons.lock), // إضافة أيقونة صغيرة
                              border: OutlineInputBorder(),
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.length < 6) {
                                return 'كلمة المرور يجب أن تكون على الأقل 6 أحرف';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),

                          // حقل تأكيد كلمة المرور مع أيقونة
                          TextFormField(
                            controller: controller.confirmPasswordController,
                            decoration: InputDecoration(
                              labelText: 'تأكيد كلمة المرور',
                              prefixIcon: Icon(Icons.lock_outline), // إضافة أيقونة صغيرة
                              border: OutlineInputBorder(),
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value != controller.passwordController.text) {
                                return 'كلمتا المرور غير متطابقتين';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),

                          // حقل العمر مع أيقونة
                          TextFormField(
                            controller: controller.ageController,
                            decoration: InputDecoration(
                              labelText: 'العمر',
                              prefixIcon: Icon(Icons.calendar_today_outlined), // إضافة أيقونة صغيرة
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty || int.tryParse(value) == null) {
                                return 'الرجاء إدخال عمر صالح';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),

                          // حقل الصفة الدراسية مع أيقونة
                          DropdownButtonFormField<String>(
                            value: controller.selectedRole.value.isEmpty
                                ? null
                                : controller.selectedRole.value,
                            decoration: InputDecoration(
                              labelText: 'الصفة الدراسية',
                              prefixIcon: Icon(Icons.school_outlined), // إضافة أيقونة صغيرة
                              border: OutlineInputBorder(),
                            ),
                            items: roles.map((String role) {
                              return DropdownMenuItem<String>(
                                value: role,
                                child: Text(role),
                              );
                            }).toList(),
                            onChanged: (value) {
                              controller.selectedRole.value = value!;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'الرجاء اختيار الصفة الدراسية';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 30),

                          // زر إنشاء الحساب
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                if (controller.formKey.currentState!.validate()) {
                                  controller.register(); // يتم رفع الصورة بعد إنشاء الحساب
                                }
                              },
                              child: Text(
                                'إنشاء حساب',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue, // لون الزر
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 15), // حجم الزر
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),

              // مؤشر التحميل
              Obx(() {
                return controller.isLoading.value
                    ? Container(
                  color: Colors.black54, // لون خلفية نصف شفاف
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white), // لون الدائرة
                    ),
                  ),
                )
                    : SizedBox.shrink(); // إذا لم يكن في حالة تحميل، لا نعرض شيء
              }),
            ],
          ),
        ),
      ),
    );
  }
}
