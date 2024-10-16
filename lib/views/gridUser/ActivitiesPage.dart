import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/admin/ActivityController.dart';

class ActivitiesPage extends StatelessWidget {
  ActivityController activityController = Get.put(ActivityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الأنشطة'),
        backgroundColor: Colors.blue.shade400,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          // التحقق من وجود نشاطات
          if (activityController.activities.isEmpty) {
            return Center(child: Text('لا توجد نشاطات حالياً'));
          }

          return ListView.builder(
            itemCount: activityController.activities.length,
            itemBuilder: (context, index) {
              final activity = activityController.activities[index]; 
              return Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                margin: EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      // أيقونة النشاط
                      Icon(
                        Icons.directions_run,
                        color: Colors.blue.shade400,
                        size: 40,
                      ),
                      SizedBox(width: 16),
                      // تفاصيل النشاط
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              activity['name'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade900,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'عدد النقاط: ${activity['points']}',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // زر حذف النشاط
                      activityController.userEmail.value == "0" ?  IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          // تأكيد الحذف
                          Get.defaultDialog(
                            title: 'تأكيد الحذف',
                            middleText: 'هل أنت متأكد من حذف هذا النشاط؟',
                            textCancel: 'إلغاء',
                            textConfirm: 'حذف',
                            confirmTextColor: Colors.white,
                            onConfirm: () {
                              activityController.deleteActivity(activity['docId']); // استخدام معرف الوثيقة
                              Get.back(); // إغلاق مربع الحوار
                            },
                          );
                        },
                      ) : Container(),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
