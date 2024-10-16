import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypoints/views/auth/LoginScreen.dart';
import '../../utils/colors.dart';
import '../../utils/images.dart';

class MainAuth extends StatelessWidget {
  const MainAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              width: 340,
              height: 450,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade900, Colors.blue.shade600],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // تحسين عرض الصورة مع إضافة حدود دائرية وتظليل
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                        image: DecorationImage(
                          image: AssetImage('assets/images/image_2.jpg'),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),


                    Text(
                      'إدارة مسجد',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    Text(
                      'عبد الله ابن حذافة السهمي',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40),
                    // تحسين زر الدخول كطالب
                    ElevatedButton(
                      onPressed: () {
                        Get.to(LoginScreen());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 8,
                      ),
                      child: Text(
                        'الدخول كطالب',
                        style: TextStyle(
                          color: AppColors.buttonColor,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // تحسين زر الدخول كمشرف
                    ElevatedButton(
                      onPressed: () {
                        // توجيه المستخدم لصفحة تسجيل الدخول كمشرف
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 8,
                      ),
                      child: Text(
                        'الدخول كمشرف',
                        style: TextStyle(
                          color: AppColors.buttonColor,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
