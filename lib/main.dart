import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:mypoints/utils/app_routes.dart';
import 'package:mypoints/utils/app_theme.dart';
import 'package:mypoints/utils/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey:
        "AIzaSyB6O12DRCjTf6shjKt3VMc1SCtRrkm9Ork", // paste your api key here
        appId:
        "1:560758016974:android:529ce76a702b6156beb99f", //paste your app id here
        messagingSenderId: "560758016974", //paste your messagingSenderId here
        projectId: "mosque-management-d55ea", //paste your project id here
        storageBucket: "mosque-management-d55ea.appspot.com",  // تأكد من إضافة bucket الصحيح

      )
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      textDirection: TextDirection.rtl,
      getPages: AppRoutes.namedRoutes,
      initialRoute: RouteWrapper.getInitialRoute,
      defaultTransition: Transition.fadeIn,
    );
  }

}

