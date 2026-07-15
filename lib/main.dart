import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garzon_mobrog/screens/splash_screen.dart';

// import '../screens/detail_screen.dart';
import '../screens/home_screen.dart';
import '../screens/newsfeed_screen.dart';
import '../screens/notification_screen.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';

 
void main() => runApp(const GarzonFacebook());
 
class GarzonFacebook extends StatelessWidget {
  const GarzonFacebook({super.key});
 
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 715),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Garzon Facebook',
          initialRoute: '/splash',
          routes: {
            '/newsfeed': (context) => const NewsFeedScreen(),
            '/home': (context) => const HomeScreen(),
            '/notifications': (context) => const NotificationScreen(),
            '/login': (context) => const LogInScreen(),
            '/register': (context) => const RegisterScreen(),
            '/splash': (context) => const SplashScreen(),
          },
        );
      },
    );
  }
}
 