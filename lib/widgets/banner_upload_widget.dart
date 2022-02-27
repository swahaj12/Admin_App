import 'dart:html';

import 'package:admin_pannel_app/services/firebase_service.dart';
import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:firebase/firebase.dart' as fb;

class BannerUploadSwidget extends StatefulWidget {
  const BannerUploadSwidget({Key? key}) : super(key: key);

  @override
  _BannerUploadSwidgetState createState() => _BannerUploadSwidgetState();
}

class _BannerUploadSwidgetState extends State<BannerUploadSwidget> {
  FirebaseServices _services = FirebaseServices();
  var _fileNameTextController = TextEditingController();
  bool _imageSelected = true;
  String? _url;
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
      child: Padding(
        padding: const EdgeInsets.only(left: 30.0),
        child: Row(
          children: [
            Visibility(
              visible: _visible,
              child: Container(
                child: Row(
                  children: [
                    AbsorbPointer(
                      absorbing: true,
                      child: SizedBox(
                          width: 300,
                          height: 30,
                          child: TextField(
                            controller: _fileNameTextController,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1)),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'No Image selected',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.only(left: 20),
                            ),
                          )),
                    ),
                    // ignore: deprecated_member_use
                    FlatButton(
                      child: Text(
                        'Upload image',
                        style: TextStyle(color: Colors.grey),
                      ),
                      onPressed: () {
                        uploadStorage();
                      },
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),

                    AbsorbPointer(
                      absorbing: _imageSelected,
                      // ignore: deprecated_member_use
                      child: FlatButton(
                        child: Text(
                          'Save image',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          progressDialog.show();
                          _services
                              .uploadBannerImageToDb(_url)
                              .then((downloadUrl) {
                            if (downloadUrl != null) {
                              progressDialog.dismiss();
                              _services.showMyDialog(
                                  title: 'New Banner Image',
                                  message: 'Saved Banner Image Suceessfully',
                                  context: context);
                            }
                          });
                        },
                        color: _imageSelected ? Colors.black12 : Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: _visible ? false : true,
              // ignore: deprecated_member_use
              child: FlatButton(
                color: Colors.black54,
                child: Text(
                  'Add new Banner',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  _visible = true;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void uploadImage({required Function(File file) onSelected}) {
    FileUploadInputElement uploadInput = FileUploadInputElement();
    uploadInput.accept = 'image/*';

    uploadInput.click();
    uploadInput.onChange.listen((event) {
      final file = uploadInput.files!.first;
      final reader = FileReader();
      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((event) {
        onSelected(file);
      });
    });
  }

  void uploadStorage() {
    final dateTime = DateTime.now();
    final path = 'bannerImage/$dateTime';
    uploadImage(onSelected: (file) {
      if (file != null) {
        setState(() {
          _fileNameTextController.text = file.name;
          _imageSelected = false;
          _url = path;
        });
        fb
            .storage()
            .refFromURL('gs://flutter-food-app-d8374.appspot.com')
            .child(path)
            .put(file);
      }
    });
  }
}
