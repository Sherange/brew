import 'package:cloud_firestore/cloud_firestore.dart';

class ImageService {
  final String? uid;

  ImageService({this.uid});

  //collection referance
  final CollectionReference imageCollection =
      FirebaseFirestore.instance.collection('images');

  // save user images
  Future saveUserImage(String imagePath) async {
    return await imageCollection
        .doc(uid)
        .collection("user_uploads")
        .doc()
        .set({'url': imagePath});
  }

  //get user Image stream
  Stream<QuerySnapshot> get images {
    return imageCollection.doc(uid).collection('user_uploads').snapshots();
  }
}
