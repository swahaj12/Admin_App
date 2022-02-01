import 'package:admin_pannel_app/screens/admin_user.dart';
import 'package:admin_pannel_app/screens/category_screen.dart';
import 'package:admin_pannel_app/screens/login_screen.dart';
import 'package:admin_pannel_app/screens/manage_banners.dart';
import 'package:admin_pannel_app/screens/notification_screen.dart';
import 'package:admin_pannel_app/screens/order_screen.dart';
import 'package:admin_pannel_app/screens/settings_screen.dart';
import 'package:admin_pannel_app/services/sidebar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String id = 'home-screen';
  @override
  Widget build(BuildContext context) {
    SideBarWidget _sideBar = SideBarWidget();

    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          'Food App Dashboard',
          style: TextStyle(color: Colors.white),
        ),
      ),
      sideBar: _sideBar.sideBarMenus(context, HomeScreen.id),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Text(
            'Dashboard',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 36,
            ),
          ),
        ),
      ),
    );
  }
}
