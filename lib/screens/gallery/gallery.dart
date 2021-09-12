import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:brew_crew/screens/add_image/add_image.dart';
import 'package:brew_crew/services/image_service.dart';
import 'package:brew_crew/shared/loading.dart';

class Gallery extends StatefulWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Coffe Gallery'),
        elevation: 0.0,
        backgroundColor: Colors.brown[400],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.brown[400],
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddImage())),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: ImageService(uid: user?.uid).images,
        initialData: null,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: GridView.builder(
                  itemCount: snapshot.data!.docs.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    QueryDocumentSnapshot docSnapshot =
                        snapshot.data!.docs[index];
                    Map<String, dynamic> snapshotData =
                        docSnapshot.data() as Map<String, dynamic>;

                    return Container(
                      margin: EdgeInsets.all(3),
                      child: FadeInImage.memoryNetwork(
                          fit: BoxFit.cover,
                          placeholder: kTransparentImage,
                          image: snapshotData["url"]),
                    );
                  }),
            );
          } else {
            return Loading();
          }
        },
      ),
    );
  }
}
