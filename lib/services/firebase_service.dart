import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FirebaseServices {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference banners = FirebaseFirestore.instance.collection('slider');
  CollectionReference vendors =
      FirebaseFirestore.instance.collection('vendors');
  CollectionReference category =
      FirebaseFirestore.instance.collection('category');
  CollectionReference boys = FirebaseFirestore.instance.collection('boys');

  FirebaseStorage storage = FirebaseStorage.instance;
  Future<DocumentSnapshot> getAdminCredentials(id) {
    var result = FirebaseFirestore.instance.collection('Admin').doc(id).get();
    return result;
  }

  Future<String> uploadBannerImageToDb(url) async {
    String downloadUrl = await storage.ref(url).getDownloadURL();
    if (downloadUrl != null) {
      firestore.collection('slider').add({
        'image': downloadUrl,
      });
    }
    return downloadUrl;
  }

  deleteBannerImagefromDb(id) async {
    firestore.collection('slider').doc(id).delete();
  }

  updateVednorStatus({id, status}) async {
    vendors.doc(id).update({'accVerified': status ? false : true});
  }

  updateTopPickedVednorStatus({id, status}) async {
    vendors.doc(id).update({'isTopPicked': status ? false : true});
  }

  Future<String> uploadCategoryImageToDb(url, catName) async {
    String downloadUrl = await storage.ref(url).getDownloadURL();
    if (downloadUrl != null) {
      category.doc(catName).set({
        'image': downloadUrl,
        'name': catName,
      });
    }
    return downloadUrl;
  }

  Future<void> saveDeliveryBoys(email, password) async {
    boys.doc(email).set({
      'accVerified': false,
      'address': '',
      'email': email,
      'imageUrl': '',
      'location': GeoPoint(0, 0),
      'mobile': '',
      'name': '',
      'password': password,
      'uid': '',
    });
  }

  updateDeliveryboyStatus({id, context, status}) async {
    ArsProgressDialog progressDialog = ArsProgressDialog(
      context,
      blur: 2,
      backgroundColor: Colors.deepOrange.withOpacity(.3),
      animationDuration: Duration(milliseconds: 500),
    );
    progressDialog.show();

    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('boys').doc(id);

    return FirebaseFirestore.instance
        .runTransaction((transaction) async {
          // Get the document
          DocumentSnapshot snapshot = await transaction.get(documentReference);

          if (!snapshot.exists) {
            throw Exception("User does not exist!");
          }

          // Perform an update on the document
          transaction.update(documentReference, {'accVerified': status});

          // Return the new count
        })
        .then((value) => {
              progressDialog.dismiss(),
              showMyDialog(
                  title: 'Delivery Boy Status',
                  message: status == true
                      ? 'Delivery boy approved status updated as Approved'
                      : 'Delivery boy approved status updated as not Approved',
                  context: context)
            })
        .catchError((error) => showMyDialog(
              title: 'Delivery Boy Status',
              context: context,
              message: 'Failed to update delivery boy status $error',
            ));
  }

  Future<void> confirmDeleteDialog({title, message, context, id}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
                Text('Please try again'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                deleteBannerImagefromDb(id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showMyDialog({title, message, context}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
