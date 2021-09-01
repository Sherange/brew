import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/user_data.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({this.uid});

  //collection referance
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  Future updateUser(String sugar, String name, int strength) async {
    return await brewCollection
        .doc(uid)
        .set({'sugar': sugar, 'name': name, 'strength': strength});
  }

  //get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  //brew lsit from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) => Brew(
            name: doc["name"] ?? "",
            sugar: doc["sugar"] ?? "",
            strength: doc["strength"] ?? 0))
        .toList();
  }

  //get user doc stream
  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  //user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> snapshotData = snapshot.data() as Map<String, dynamic>;
    return UserData(
        name: snapshotData["name"],
        sugar: snapshotData["sugar"],
        strength: snapshotData["strength"]);
  }
}
