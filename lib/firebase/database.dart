import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DatabaseMethods {
  Future addDay(Map<String, dynamic> dayinfo) async {
    var userData = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    var dayData = await FirebaseFirestore.instance
        .collection("Days")
        .get()
        .then((QuerySnapshot data) {
      if (data.docs.isNotEmpty) {
        DocumentSnapshot doc = data.docs.first;
        SnackBar(
          content: Text(doc["day"]),
        );
      } else {
        const SnackBar(
          content: Text("No Document Found"),
        );
      }
    });

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
          "streak": 0
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
