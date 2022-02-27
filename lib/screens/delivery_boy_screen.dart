import 'package:admin_pannel_app/services/firebase_service.dart';
import 'package:admin_pannel_app/services/sidebar.dart';
import 'package:admin_pannel_app/widgets/deliveryboy_widget/approved_deliveryboys.dart';
import 'package:admin_pannel_app/widgets/deliveryboy_widget/create_deliveryboy_widget.dart';
import 'package:admin_pannel_app/widgets/deliveryboy_widget/new_deliveryboy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class DeliveryBoyScreen extends StatelessWidget {
  const DeliveryBoyScreen({Key? key}) : super(key: key);

  static const String id = 'deliveryorder-screen';

  @override
  Widget build(BuildContext context) {
    SideBarWidget _sideBar = SideBarWidget();
    return DefaultTabController(
      length: 2,
      child: AdminScaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black87,
          iconTheme: IconThemeData(color: Colors.white),
          title: const Text(
            'Food App Dashboard',
            style: TextStyle(color: Colors.white),
          ),
        ),
        sideBar: _sideBar.sideBarMenus(context, DeliveryBoyScreen.id),
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Delivery Boy',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 36,
                  ),
                ),
                Text('Create new Delivery Boys and Manage all of them'),
                Divider(
                  thickness: 5,
                ),
                CreateDeliveryBoyWidget(),
                Divider(
                  thickness: 5,
                ),
                TabBar(
                    indicatorColor: Theme.of(context).primaryColor,
                    labelColor: Theme.of(context).primaryColor,
                    unselectedLabelColor: Colors.black54,
                    tabs: [
                      Tab(
                        text: 'NEW',
                      ),
                      Tab(
                        text: 'APPROVED',
                      ),
                    ]),
                Expanded(
                  child: Container(
                    child: TabBarView(children: [
                      NewDeliveryBoy(),
                      ApprovedDeliveryBoys(),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
