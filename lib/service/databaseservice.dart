import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  Future savingUserData(String email, String fullname) async {
    return await userCollection
        .doc(uid)
        .set({"email": email, "Name": fullname});
  }

  Future gettingUserdata(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }
}
