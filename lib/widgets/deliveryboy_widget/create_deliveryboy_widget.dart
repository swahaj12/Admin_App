import 'package:admin_pannel_app/services/firebase_service.dart';
import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:flutter/material.dart';

class CreateDeliveryBoyWidget extends StatefulWidget {
  const CreateDeliveryBoyWidget({Key? key}) : super(key: key);

  @override
  _CreateDeliveryBoyWidgetState createState() =>
      _CreateDeliveryBoyWidgetState();
}

class _CreateDeliveryBoyWidgetState extends State<CreateDeliveryBoyWidget> {
  FirebaseServices _services = FirebaseServices();
  var emailText = TextEditingController();
  var passText = TextEditingController();
  bool _visible = false;
  @override
  Widget build(BuildContext context) {
    ArsProgressDialog progressDialog = ArsProgressDialog(
      context,
      blur: 2,
      backgroundColor: Colors.deepOrange.withOpacity(.3),
      animationDuration: Duration(milliseconds: 500),
    );
    return Container(
      color: Colors.grey,
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: Row(
        children: [
          Visibility(
            visible: _visible ? false : true,
            child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Container(
                child: ElevatedButton(
                  child: Text(
                    'Create new Delivery Boy',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    setState(() {
                      _visible = true;
                    });
                  },
                ),
              ),
            ),
          ),
          Visibility(
            visible: _visible,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Container(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 200,
                        height: 30,
                        child: TextField(
                          controller: emailText,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 1)),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Email ID',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.only(
                              left: 20,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 200,
                        height: 30,
                        child: TextField(
                          controller: passText,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 1)),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Password',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.only(
                              left: 20,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        child: Text(
                          'Save',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          if (emailText.text.isEmpty) {
                            _services.showMyDialog(
                                context: context,
                                title: 'Email ID',
                                message: 'Email Id not entered');
                          } else if (passText.text.isEmpty) {
                            _services.showMyDialog(
                                context: context,
                                title: 'Password',
                                message: 'Password not entered');
                          } else if (passText.text.length < 6) {
                            _services.showMyDialog(
                                context: context,
                                title: 'Password',
                                message: 'Minimum 6 characters');
                          }
                          progressDialog.show();
                          _services
                              .saveDeliveryBoys(emailText.text, passText.text)
                              .whenComplete(() {
                            emailText.clear();
                            passText.clear();
                            progressDialog.dismiss();
                            _services.showMyDialog(
                                context: context,
                                title: 'Save Delivery Boy',
                                message: 'Save Successfully');
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
