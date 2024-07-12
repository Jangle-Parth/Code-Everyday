import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class DatabaseMethods {
  Future addDay(Map<String, dynamic> dayinfo) async {
    return await FirebaseFirestore.instance.collection("Days").add(dayinfo);
  }

  Future<Stream<QuerySnapshot>> getDays() async {
    return await FirebaseFirestore.instance.collection("Days").snapshots();
  }

  Stream<DocumentSnapshot> getUserStream() {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .snapshots();
  }

  Future registerUser(
      String email, String password, String username, String headline) async {
    try {
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd').format(now);
      if (username.isNotEmpty && email.isNotEmpty) {
        UserCredential cred = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        Map<String, dynamic> user = {
          "name": username,
          "email": email,
          "uid": cred.user?.uid,
          "days": 0,
          "headline": headline,
          "rank": 0,
          "streak": 0,
          "lastpostdate": formattedDate,
        };

        return await FirebaseFirestore.instance
            .collection("users")
            .doc(cred.user?.uid)
            .set(user);
      }
    } catch (e) {}
  }

  Future<void> updateDay() async {
    try {
      DocumentReference userDocRef = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid);

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot userDocSnapshot = await transaction.get(userDocRef);
        if (userDocSnapshot.exists) {
          int currentDays = userDocSnapshot['days'];
          transaction.update(userDocRef, {'days': currentDays + 1});
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}
