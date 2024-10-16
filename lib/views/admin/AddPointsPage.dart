import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/admin/AddPointsController.dart';

class AddPointsPage extends StatelessWidget {
  AddPointsController _controller = Get.put(AddPointsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('إضافة وحذف نقاط'),
        backgroundColor: Colors.cyanAccent.shade400,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          // عرض دائرة التحميل عند انتظار جلب البيانات
          if (_controller.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.cyanAccent.shade400,
              ),
            );
          }

          return Column(
            children: [
              // قائمة المستخدمين
              DropdownButtonFormField<String>(
                value: _controller.selectedUser.value.isEmpty ? null : _controller.selectedUser.value,
                items: _controller.users.map((user) {
                  return DropdownMenuItem<String>(
                    value: user['id'],
                    child: Text(
                      user['name'],
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  _controller.selectedUser.value = value!;
                },
                decoration: InputDecoration(
                  labelText: 'اختر المستخدم',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                dropdownColor: Colors.white,
              ),
              SizedBox(height: 16),
              // قائمة النشاطات
              DropdownButtonFormField<String>(
                value: _controller.selectedActivity.value.isEmpty ? null : _controller.selectedActivity.value,
                items: _controller.activities.map((activity) {
                  return DropdownMenuItem<String>(
                    value: activity['id'],
                    child: Text(
                      activity['name'],
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  _controller.selectedActivity.value = value!;
                  _controller.fetchActivityPoints();
                },
                decoration: InputDecoration(
                  labelText: 'اختر النشاط',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                dropdownColor: Colors.white,
              ),
              SizedBox(height: 16),
              // عرض النقاط المستحقة
              Text(
                'النقاط المستحقة: ${_controller.selectedActivityPoints.value}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue.shade700),
              ),
              SizedBox(height: 24),
              // زر إضافة النقاط
              ElevatedButton(
                onPressed: () {
                  _controller.addPointsToUser();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyanAccent.shade400,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                child: _controller.isProcessing.value
                    ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
                    : Text('إضافة النقاط'),
              ),
              SizedBox(height: 16),
              // زر حذف النقاط
              ElevatedButton(
                onPressed: () {
                  _controller.removePointsFromUser();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                child: _controller.isProcessing.value
                    ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
                    : Text('حذف النقاط'),
              ),
            ],
          );
        }),
      ),
    );
  }
}
