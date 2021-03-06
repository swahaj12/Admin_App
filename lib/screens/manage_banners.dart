import 'dart:html';

import 'package:admin_pannel_app/screens/homescreen.dart';
import 'package:admin_pannel_app/services/firebase_service.dart';

import 'package:admin_pannel_app/services/sidebar.dart';
import 'package:admin_pannel_app/widgets/banner_upload_widget.dart';
import 'package:admin_pannel_app/widgets/banner_widget.dart';
import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:firebase/firebase.dart' as fb;

class BannerScreen extends StatelessWidget {
  static const String id = 'banner-screen';
  const BannerScreen({Key? key}) : super(key: key);

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
      sideBar: _sideBar.sideBarMenus(context, BannerScreen.id),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Banner Screen',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                ),
              ),
              Text('Add/ Delete Home Screen Banner Images'),
              Divider(
                thickness: 5,
              ),
              BannerWidget(),
              Divider(
                thickness: 5,
              ),
              BannerUploadSwidget(),
            ],
          ),
        ),
      ),
    );
  }
}
