import 'package:get/get.dart';
import 'package:mypoints/views/home/HomeScreen.dart';

import '../views/auth/LoginScreen.dart';
import '../views/auth/RegisterScreen.dart';
import '../views/auth/main_auth.dart';
import 'cache_helper.dart';


class AppRoutes {
  static final List<GetPage> namedRoutes = [
    GetPage(
      name: RoutesPath.home,
      page: () =>  HomeScreen()),
    // ),
    // GetPage(
    //   name: RoutesPath.homeSupervisor,
    //   page: () => const HomeSupervisorPage(),
    // ),
    GetPage(
      name: RoutesPath.auth,
      page: () => const MainAuth(),
    ),
    // GetPage(
    //   name: RoutesPath.loginStudent,
    //   page: () => LoginScreen(),
    // ),
    // GetPage(
    //   name: RoutesPath.loginSupervisor,
    //   page: () => LoginSupervisor(),
    // ),
    // GetPage(
    //   name: RoutesPath.signup,
    //   page: () => SignupPage(),
    // ),
    GetPage(
      name: "/test",
      page: () => LoginScreen(),
    ),
  ];
}

class RoutesPath {

  // student
  static const home = '/home';
  static const auth = '/auth';
  static const loginStudent = '/loginStudent';
  static const signup = '/signup';


  // supervisor
  static const homeSupervisor = '/homeSupervisor';
  static const loginSupervisor = '/loginSupervisor';


}

class RouteWrapper {
  static get getInitialRoute {

    if(CacheHelper.getData(key: "userEmail") == null) {
      return RoutesPath.auth;
    }
    else{
      return RoutesPath.home;
    }

  }
}
