import 'package:admin_pannel_app/screens/admin_user.dart';
import 'package:admin_pannel_app/screens/category_screen.dart';
import 'package:admin_pannel_app/screens/homescreen.dart';
import 'package:admin_pannel_app/screens/login_screen.dart';
import 'package:admin_pannel_app/screens/manage_banners.dart';
import 'package:admin_pannel_app/screens/notification_screen.dart';
import 'package:admin_pannel_app/screens/order_screen.dart';
import 'package:admin_pannel_app/screens/settings_screen.dart';
import 'package:admin_pannel_app/screens/splash_screen.dart';
import 'package:admin_pannel_app/screens/vendor_screen.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Panel',
      theme: ThemeData(
        primaryColor: const Color(0xFF84c225),
      ),
      home: SplashScreen(),
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        SplashScreen.id: (context) => SplashScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        BannerScreen.id: (context) => BannerScreen(),
        CategoryScreen.id: (context) => CategoryScreen(),
        OrderScreen.id: (context) => OrderScreen(),
        NotificationScreen.id: (context) => NotificationScreen(),
        AdminUsers.id: (context) => AdminUsers(),
        SettingScreen.id: (context) => SettingScreen(),
        VendorScreen.id: (context) => VendorScreen(),
      },
    );
  }
}
