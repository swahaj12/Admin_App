import 'package:admin_pannel_app/services/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseServices _services = FirebaseServices();
    return StreamBuilder<QuerySnapshot>(
      stream: _services.banners.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Container(
          width: MediaQuery.of(context).size.width,
          height: 300,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 200,
                        child: Card(
                          elevation: 10,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Image.network(
                                document['image'],
                                width: 400,
                                fit: BoxFit.fill,
                              )),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                            onPressed: () {
                              _services.confirmDeleteDialog(
                                context: context,
                                message: 'Are you sure you want to delete? ',
                                title: 'Delete Banner',
                                id: document.id,
                              );
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
