import 'package:admin_pannel_app/services/firebase_service.dart';
import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class NewDeliveryBoy extends StatefulWidget {
  const NewDeliveryBoy({Key? key}) : super(key: key);

  @override
  State<NewDeliveryBoy> createState() => _NewDeliveryBoyState();
}

class _NewDeliveryBoyState extends State<NewDeliveryBoy> {
  bool status = false;
  FirebaseServices _services = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream:
            _services.boys.where('accVerified', isEqualTo: false).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          QuerySnapshot? snap = snapshot.data as QuerySnapshot?;
          if (snap!.size == 0) {
            return Center(
              child: Text('No Approve Delivery boys to list'),
            );
          }
          return SingleChildScrollView(
            child: DataTable(
              showBottomBorder: true,
              dataRowHeight: 40,
              headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
              columns: <DataColumn>[
                DataColumn(
                  label: Expanded(child: Text('Profile pic')),
                ),
                DataColumn(
                  label: Text('Name'),
                ),
                DataColumn(
                  label: Text('Email'),
                ),
                DataColumn(
                  label: Text('Mobile'),
                ),
                DataColumn(
                  label: Text('Address'),
                ),
                DataColumn(
                  label: Text('Actions'),
                ),
              ],
              rows: _deliveryboyList(snapshot.data as QuerySnapshot),
            ),
          );
        },
      ),
    );
  }

  List<DataRow> _deliveryboyList(snapshot) {
    List<DataRow> newList =
        snapshot.docs.map<DataRow>((DocumentSnapshot document) {
      print(document.data().length);
      if (document != null) {
        return DataRow(cells: [
          DataCell(
            Container(
                width: 60,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: document['imageUrl'] == ''
                      ? Icon(
                          Icons.person,
                          size: 40,
                        )
                      : Image.network(
                          document['imageUrl'],
                          fit: BoxFit.contain,
                        ),
                )),
          ),
          DataCell(
            Text(document['name']),
          ),
          DataCell(
            Text(document['email']),
          ),
          DataCell(
            Text(document['mobile']),
          ),
          DataCell(
            Text(document['address']),
          ),
          DataCell(document['mobile'] == ''
              ? Text('No Registered')
              : FlutterSwitch(
                  activeText: 'Approved',
                  inactiveText: 'Not Approved',
                  value: document.data()['accVerified'],
                  valueFontSize: 10.0,
                  width: 110,
                  borderRadius: 30.0,
                  showOnOff: true,
                  onToggle: (val) {
                    _services.updateDeliveryboyStatus(
                        id: document.id, context: context, status: true);
                  },
                )),
        ]);
      }
    }).toList();
    return newList;
  }
}
