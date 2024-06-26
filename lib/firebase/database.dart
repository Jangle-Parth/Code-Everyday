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

  Future registerUser(String email, String password, String username) async {
    try {
      if (username.isNotEmpty && email.isNotEmpty) {
        UserCredential user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
            await FirebaseFirestore.instance.collection("users").doc(user.)
      }
    } catch (e) {}
  }
}