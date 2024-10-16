import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/gridUser/PointsController.dart';

class PointsSystemScreen extends StatelessWidget {
  // الحصول على instance من الكونترولر
  final PointsController pointsController = Get.put(PointsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('نظام النقاط'),
        backgroundColor: Colors.green.shade800,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // استخدام Obx لمراقبة التغييرات في القائمة
            Expanded(
              child: Obx(() {
                if (pointsController.users.isEmpty) {
                  // عرض رسالة عند عدم وجود بيانات
                  return Center(
                    child: Text('لا يوجد مستخدمين'),
                  );
                }

                // بناء القائمة بناءً على البيانات من الكونترولر
                return ListView.builder(
                  itemCount: pointsController.users.length,
                  itemBuilder: (context, index) {
                    var user = pointsController.users[index];
                    if (index < 3) {
                      // تصميم مميز لأول ثلاثة
                      return buildTopThreeUser(user, index + 1);
                    } else if (index >= pointsController.users.length - 2) {
                      // تصميم مميز لآخر اثنين
                      return buildLastTwoUsers(user, index + 1);
                    } else {
                      // التصميم العادي للباقي
                      return buildNormalUser(user, index + 1);
                    }
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // تصميم المستخدمين في أول ثلاثة مراكز مع أوسمة
  Widget buildTopThreeUser(Map<String, dynamic> user, int rank) {
    IconData medalIcon;
    Color medalColor;

    switch (rank) {
      case 1:
        medalIcon = Icons.emoji_events;
        medalColor = Colors.amber; // ذهبية للأول
        break;
      case 2:
        medalIcon = Icons.emoji_events;
        medalColor = Colors.grey; // فضية للثاني
        break;
      case 3:
        medalIcon = Icons.emoji_events;
        medalColor = Colors.brown; // برونزية للثالث
        break;
      default:
        medalIcon = Icons.star;
        medalColor = Colors.blueGrey;
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: medalColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: medalColor, width: 2),
      ),
      child: ListTile(
        leading: Icon(medalIcon, color: medalColor, size: 30),
        title: Text(
          '${user['username']} - ${user['points']} نقاط',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        trailing: Text(
          '#$rank',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // تصميم المستخدمين في آخر اثنين
  Widget buildLastTwoUsers(Map<String, dynamic> user, int rank) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.red.shade100,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.red.shade400, width: 2),
      ),
      child: ListTile(
        leading: Icon(Icons.arrow_downward, color: Colors.red.shade400, size: 30),
        title: Text(
          '${user['username']} - ${user['points']} نقاط',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        trailing: Text(
          '#$rank',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red.shade400),
        ),
      ),
    );
  }

  // تصميم المستخدمين العاديين
  Widget buildNormalUser(Map<String, dynamic> user, int rank) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(Icons.person, color: Colors.blueGrey, size: 30),
        title: Text(
          '${user['username']} - ${user['points']} نقاط',
          style: TextStyle(fontSize: 16),
        ),
        trailing: Text(
          '#$rank',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
