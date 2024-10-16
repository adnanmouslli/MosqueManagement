import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../controllers/admin/ActivityController.dart';

class AddActivityPage extends StatelessWidget {
  final ActivityController activityController = Get.put(ActivityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('إضافة نشاط'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // إدخال اسم النشاط
            Text(
              'اسم النشاط',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: activityController.activityNameController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.edit, color: Colors.blueAccent),
                labelText: 'أدخل اسم النشاط',
                labelStyle: TextStyle(color: Colors.blueAccent),
                filled: true,
                fillColor: Colors.blue[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 16),
            // إدخال عدد النقاط المستحقة
            Text(
              'عدد النقاط المستحقة',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: activityController.pointsController,
              keyboardType: TextInputType.number, // السماح فقط بالأرقام
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.confirmation_number, color: Colors.blueAccent),
                labelText: 'أدخل عدد النقاط',
                labelStyle: TextStyle(color: Colors.blueAccent),
                filled: true,
                fillColor: Colors.blue[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 24),
            // زر حفظ النشاط
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // استدعاء الميثود لحفظ البيانات
                  activityController.addActivity();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'إضافة النشاط',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
