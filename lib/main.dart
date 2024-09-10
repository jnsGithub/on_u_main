import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:on_u/view/chat/chatListView.dart';
import 'package:on_u/view/chat/chatRoom/chatRoomView.dart';
import 'package:on_u/view/counselReservation/reservationDetail/reservationDetailView.dart';
import 'package:on_u/view/home/homeView.dart';
import 'package:on_u/view/login/findPassword/findPasswordView.dart';
import 'package:on_u/view/login/loginView.dart';
import 'package:on_u/view/login/signUp/signUpCompanyView.dart';
import 'package:on_u/view/login/signUp/signUpView.dart';
import 'package:on_u/view/mainView.dart';
import 'package:on_u/view/myPage/contactUs/contactUs.dart';
import 'package:on_u/view/myPage/resrvationList/reservationListView.dart';
import 'package:on_u/view/program/programController.dart';
import 'package:on_u/view/program/programDetail/programDetailView.dart';
import 'package:on_u/view/program/programView.dart';
import 'package:on_u/view/psychologicalTest/psychologicalTestView.dart';
import 'package:on_u/view/counselReservation/reservation/reservationCalendarView.dart';
import 'package:on_u/view/counselReservation/counselorListController.dart';
import 'package:on_u/view/counselReservation/counselorDetail/counselorDetailView.dart';
import 'package:on_u/view/counselReservation/counselorListView.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDateFormatting();
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
        GetPage(name: '/findPasswordView', page: () => const FindPasswordView()),
        GetPage(name: '/homeView', page: () => HomeView()),
        GetPage(name: '/programView', page: () => const ProgramView()),
        GetPage(name: '/programDetailView', page: () => const ProgramDetailView()),
        GetPage(name: '/psychologicalTestView', page: () => const PsychologicalTestView()),
        GetPage(name: '/counselorListView', page: () => const CounselorListView()),
        GetPage(name: '/counselorDetailView', page: () => const CounselorDetailView()),
        GetPage(name: '/reservaionCalendarView', page: () => const ReservationCalendarView()),
        GetPage(name: '/reservationDetailView', page: () => ReservationDetailView()),
        GetPage(name: '/chatListView', page: () => ChatListView()),
        GetPage(name: '/chatRoomView', page: () => ChatRoomView()),
        GetPage(name: '/reservationListView', page: () => const ReservationListView()),
        GetPage(name: '/contactUsView', page: () => const ContactUs()),
      ],
    );
  }
}
