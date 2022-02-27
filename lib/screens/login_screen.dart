import 'package:admin_pannel_app/screens/homescreen.dart';
import 'package:admin_pannel_app/services/firebase_service.dart';
import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String id = 'login-screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final _formKey = GlobalKey<FormState>();
  FirebaseServices _services = FirebaseServices();
  var _usernameTextController = TextEditingController();
  var _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ArsProgressDialog progressDialog = ArsProgressDialog(
      context,
      blur: 2,
      backgroundColor: Colors.deepOrange.withOpacity(.3),
      animationDuration: Duration(milliseconds: 500),
    );

    _login({username, password}) async {
      progressDialog.show();
      _services.getAdminCredentials(username).then((value) async {
        if (value.exists) {
          if (value['username'] == username) {
            if (value['password'] == password) {
              //if both is correct, will login
              try {
                UserCredential userCredential =
                    await FirebaseAuth.instance.signInAnonymously();
                if (userCredential != null) {
                  //if signin success,will navigate to homescreen
                  progressDialog.dismiss();
                  Navigator.pushReplacementNamed(context, HomeScreen.id);
                }
              } catch (e) {
                //if signin failed
                progressDialog.dismiss();
                _services.showMyDialog(
                    title: 'Login',
                    context: context,
                    message: '${e.toString()}');
              }
              return;
            }
            //if password incorrect
            progressDialog.dismiss();
            _services.showMyDialog(
                context: context,
                title: 'Incorrect Password',
                message: 'Password you have entered in invalid');
            return;
          }
          //if username incorrect
          progressDialog.dismiss();
          _services.showMyDialog(
              context: context,
              title: 'Invalid Username',
              message: 'Username you have entered in incorrect');
        }
        //if username incorrect
        progressDialog.dismiss();
        _services.showMyDialog(
            context: context,
            title: 'Invalid Username',
            message: 'Username you have entered in incorrect');
      });
    }

    return Scaffold(
      body: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Connection failed'),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.deepOrange, Colors.white],
                    stops: [1.0, 1.0],
                    begin: Alignment.topCenter,
                    end: Alignment(0.0, 0.0)),
              ),
              child: Center(
                // ignore: sized_box_for_whitespace
                child: Container(
                  width: 300,
                  height: 500,
                  child: Card(
                    elevation: 6,
                    shape: Border.all(color: Colors.deepOrange, width: 2),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // ignore: avoid_unnecessary_containers
                            Container(
                              child: Column(
                                children: [
                                  Image.asset('images/logo.png'),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text(
                                    'Foodie Admin Panel',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 20),
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  TextFormField(
                                    controller: _usernameTextController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter Username';
                                      }

                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        prefixIcon: const Icon(Icons.person),
                                        labelText: 'User Name',
                                        contentPadding: const EdgeInsets.only(
                                            left: 20, right: 20),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                width: 2))),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    controller: _passwordTextController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter Password';
                                      }
                                      if (value.length < 6) {
                                        return 'Minimum 6 Characters';
                                      }

                                      return null;
                                    },
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        labelText: 'Minimum 6 Characters',
                                        prefixIcon:
                                            const Icon(Icons.vpn_key_sharp),
                                        hintText: 'Password',
                                        contentPadding: const EdgeInsets.only(
                                            left: 20, right: 20),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                width: 2))),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  // ignore: deprecated_member_use
                                  child: FlatButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          _login(
                                            username:
                                                _usernameTextController.text,
                                            password:
                                                _passwordTextController.text,
                                          );
                                        }
                                      },
                                      color: Theme.of(context).primaryColor,
                                      child: const Text(
                                        'Login',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
