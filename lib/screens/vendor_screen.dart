import 'package:admin_pannel_app/services/sidebar.dart';
import 'package:admin_pannel_app/widgets/vendor_datatable_widget.dart';
import 'package:admin_pannel_app/widgets/vendor_filter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class VendorScreen extends StatefulWidget {
  static const String id = 'vendor-screen';
  const VendorScreen({Key? key}) : super(key: key);

  @override
  _VendorScreenState createState() => _VendorScreenState();
}

class _VendorScreenState extends State<VendorScreen> {
  SideBarWidget _sideBar = SideBarWidget();
  @override
  Widget build(BuildContext context) {
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
      sideBar: _sideBar.sideBarMenus(context, VendorScreen.id),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Manage Vendors',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                ),
              ),
              Text('Manage All vendors Activity'),
              Divider(
                thickness: 5,
              ),
              VendorFilterWidget(),
              Divider(
                thickness: 5,
              ),
              VendorDataTable(),
            ],
          ),
        ),
      ),
    );
  }
}
