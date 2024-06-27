import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseMethods {
  Future addDay(Map<String, dynamic> dayinfo, String id) async {
    return await FirebaseFirestore.instance
        .collection("Days")
        .doc(id)
        .set(dayinfo);
  }

  Future<Stream<QuerySnapshot>> getDays() async {
    return await FirebaseFirestore.instance.collection("Days").snapshots();
  }

  Future<Stream<QuerySnapshot>> getUser() async {
    return await FirebaseFirestore.instance.collection("users").snapshots();
  }

  Future registerUser(
    String email,
    String password,
    String username,
  ) async {
    try {
      if (username.isNotEmpty && email.isNotEmpty) {
        UserCredential cred = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        Map<String, dynamic> user = {
          "name": username,
          "email": email,
          "uid": cred.user?.uid
        };

        return await FirebaseFirestore.instance
            .collection("users")
            .doc(cred.user?.uid)
            .set(user);
      }
    } catch (e) {}
  }
}
