import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/admin/HomeAdminController.dart';
import '../../controllers/home/HomeController.dart';
import '../gridUser/ActivitiesPage.dart';
import '../gridUser/PointsSystemScreen.dart';
import 'AddActivityPage.dart';
import 'AddPointsPage.dart';

class HomeAdmin extends StatelessWidget {


  final HomeAdminController homeController = Get.put(HomeAdminController());

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: Text('الصفحة الرئيسية'),
        leading: IconButton(
          icon: Icon(Icons.logout, color: Colors.white),  // أيقونة تسجيل الخروج
          onPressed: () {
            // عرض نافذة تأكيد تسجيل الخروج
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('تأكيد تسجيل الخروج'),
                  content: Text('هل أنت متأكد أنك تريد تسجيل الخروج؟'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        // إغلاق النافذة بدون تسجيل الخروج
                        Navigator.of(context).pop();
                      },
                      child: Text('إلغاء'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // استدعاء دالة تسجيل الخروج في الكونترولر
                        homeController.logout();
                        //Navigator.of(context).pop();  // إغلاق النافذة بعد تسجيل الخروج
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,  // لون أحمر جذاب للزر
                      ),
                      child: Text('تأكيد' ,  style: TextStyle(color: Colors.white)),
                    ),
                  ],
                );
              },
            );
          },
        ),
        backgroundColor: Colors.blue.shade900,  // لون الخلفية للشريط العلوي
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // قسم بيانات المستخدم
              Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 4,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // أيقونة تدل على Admin بدلًا من صورة
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.blue.shade100, // لون خلفية الأيقونة
                        child: Icon(
                          Icons.admin_panel_settings, // أيقونة Admin
                          size: 40,
                          color: Colors.blue.shade900, // لون الأيقونة
                        ),
                      ),
                      SizedBox(width: 16),
                      // معلومات المستخدم الثابتة
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // اسم المستخدم (ثابت)
                            Text(
                              'مرحباً, Admin',
                              style: TextStyle(
                                fontSize: 22,  // حجم أكبر قليلاً لإبراز الاسم
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade900,  // لون أغمق لجعل النص أكثر وضوحاً
                              ),
                            ),
                            SizedBox(height: 8),
                            // البريد الإلكتروني (ثابت)
                            Text(
                              'admin@example.com',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade700,  // لون أكثر دفئًا قليلاً للبريد الإلكتروني
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 12),  // زيادة المسافة بين المعلومات والعناصر الأخرى
                            // العمر (ثابت)
                            Row(
                              children: [
                                Icon(Icons.cake, size: 22, color: Colors.orange.shade400), // لون أيقونة مختلف
                                SizedBox(width: 8),
                                Text(
                                  'العمر: 35 سنوات',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey.shade800,  // لون أغمق قليلاً لتوضيح النص
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            // الصف الدراسي (ثابت - يعبر عن دوره كـ Admin)
                            Row(
                              children: [
                                Icon(Icons.school, size: 22, color: Colors.blue.shade600),  // لون مختلف للصف الدراسي
                                SizedBox(width: 8),
                                Text(
                                  'الصف الدراسي: Admin',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey.shade800,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),


                SizedBox(height: 30),
                // شبكة المهام الرئيسية
                Text(
                  'المهام الرئيسية',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                  ),
                ),
                SizedBox(height: 16),
                GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    buildTaskBox(Icons.event, 'نظام النقاط', Colors.green.shade600 , () => {
                      Get.to(PointsSystemScreen())
                    }),
                    buildTaskBox(Icons.event, 'إضافة نشاط', Colors.blueAccent , () => {
                      Get.to(AddActivityPage())
                    }),
                    buildTaskBox(Icons.star_border_outlined, 'إضافة وحذف نقاط', Colors.cyanAccent.shade400 , () => {
                      Get.to(AddPointsPage())
                    }),
                    buildTaskBox(Icons.book, 'أساتذة المسجد', Colors.orange.shade400, () => {
                      Get.snackbar(
                        "تنبيه!!",
                        "لم يتم تفعيل الميزة بعد",
                        backgroundColor: Colors.yellow, // اللون حسب النجاح أو الخطأ
                        colorText: Colors.white, // لون النص
                        snackPosition: SnackPosition.BOTTOM, // عرض الإشعار من الأسفل
                        margin: const EdgeInsets.all(10), // هوامش للإشعار
                        borderRadius: 10, // تدوير الحواف
                        animationDuration: const Duration(milliseconds: 500), // مدة الرسوم المتحركة للإشعار
                        duration: const Duration(seconds: 3), // مدة بقاء الإشعار
                        icon: Icon(
                          Icons.warning_amber_outlined , // أيقونة حسب النجاح أو الخطأ
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
                      )
                    }),
                    buildTaskBox(Icons.directions_run, 'الأنشطة', Colors.blue.shade400, () => {
                      Get.to(ActivitiesPage())
                    }),
                    buildTaskBox(Icons.volunteer_activism, 'التبرعات', Colors.red.shade400, () => {
                      Get.snackbar(
                        "تنبيه!!",
                        "لم يتم تفعيل الميزة بعد",
                        backgroundColor: Colors.yellow.shade700, // اللون حسب النجاح أو الخطأ
                        colorText: Colors.white, // لون النص
                        snackPosition: SnackPosition.BOTTOM, // عرض الإشعار من الأسفل
                        margin: const EdgeInsets.all(10), // هوامش للإشعار
                        borderRadius: 10, // تدوير الحواف
                        animationDuration: const Duration(milliseconds: 500), // مدة الرسوم المتحركة للإشعار
                        duration: const Duration(seconds: 3), // مدة بقاء الإشعار
                        icon: Icon(
                          Icons.warning_amber_outlined , // أيقونة حسب النجاح أو الخطأ
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
                      )
                    }),
                    buildTaskBox(Icons.group, 'المجتمع', Colors.purple.shade400, () => {
                      Get.snackbar(
                        "تنبيه!!",
                        "لم يتم تفعيل الميزة بعد",
                        backgroundColor: Colors.yellow, // اللون حسب النجاح أو الخطأ
                        colorText: Colors.white, // لون النص
                        snackPosition: SnackPosition.BOTTOM, // عرض الإشعار من الأسفل
                        margin: const EdgeInsets.all(10), // هوامش للإشعار
                        borderRadius: 10, // تدوير الحواف
                        animationDuration: const Duration(milliseconds: 500), // مدة الرسوم المتحركة للإشعار
                        duration: const Duration(seconds: 3), // مدة بقاء الإشعار
                        icon: Icon(
                          Icons.warning_amber_outlined , // أيقونة حسب النجاح أو الخطأ
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
                      )
                    }),
                    buildTaskBox(Icons.notifications, 'الإشعارات', Colors.teal.shade400, () => {
                      Get.snackbar(
                        "تنبيه!!",
                        "لم يتم تفعيل الميزة بعد",
                        backgroundColor: Colors.yellow, // اللون حسب النجاح أو الخطأ
                        colorText: Colors.white, // لون النص
                        snackPosition: SnackPosition.BOTTOM, // عرض الإشعار من الأسفل
                        margin: const EdgeInsets.all(10), // هوامش للإشعار
                        borderRadius: 10, // تدوير الحواف
                        animationDuration: const Duration(milliseconds: 500), // مدة الرسوم المتحركة للإشعار
                        duration: const Duration(seconds: 3), // مدة بقاء الإشعار
                        icon: Icon(
                          Icons.warning_amber_outlined , // أيقونة حسب النجاح أو الخطأ
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
                      )
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // دالة بناء الصندوق
  Widget buildTaskBox(IconData icon, String title, Color color , Function()? onTap) {
    return GestureDetector(
      onTap:onTap ,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 4,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: color),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
