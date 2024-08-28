import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_u/view/home/homeView.dart';
import 'package:on_u/view/login/loginView.dart';
import 'package:on_u/view/login/signUp/signUpCompanyView.dart';
import 'package:on_u/view/login/signUp/signUpView.dart';
import 'package:on_u/view/mainView.dart';
import 'package:on_u/view/program/programController.dart';
import 'package:on_u/view/program/programView.dart';
import 'package:on_u/view/psychologicalTest/psychologicalTestView.dart';
import 'package:on_u/view/reservation/reservationController.dart';
import 'package:on_u/view/reservation/reservationView.dart';


void main() {
  Get.put(ProgramController());
  Get.put(ReservationController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: const Locale('ko', 'KR'),
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: false,
          fontFamily: 'Pretendard',
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
              backgroundColor:  Colors.white,
              titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w400
              ), elevation:0
          )
      ),
      initialRoute: '/loginView',
      getPages: [
        GetPage(name: '/loginView', page: () => const LoginView()),
        GetPage(name: '/signUpCompanyView', page: () => const SignUpCompanyView()),
        GetPage(name: '/signUpView', page: () => const SignUpView()),
        GetPage(name: '/mainView', page: () => const MainView()),
        GetPage(name: '/homeView', page: () => HomeView()),
        GetPage(name: '/programView', page: () => const ProgramView()),
        GetPage(name: '/psychologicalTestView', page: () => const PsychologicalTestView()),
        GetPage(name: '/reservationView', page: () => const ReservationView()),
      ],
    );
  }
}
