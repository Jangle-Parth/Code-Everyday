import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_everyday/firebase/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageForm extends StatefulWidget {
  const MessageForm({super.key});

  @override
  State<MessageForm> createState() => _MessageFormState();
}

class _MessageFormState extends State<MessageForm> {
  void _submitData() async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    if (_messagecontroller.text.isEmpty || userDoc['uid'] == null) {
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: userDoc['uid'] == null
                    ? const Text("Error Loggin in")
                    : const Text('Invalid Input'),
                content: userDoc['uid'] == null
                    ? const Text("Pls Register again")
                    : const Text('Pls Enter a Message'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text('Okay'))
                ],
              ));
    } else {
      Map<String, dynamic> dayinfo = {
        "name": userDoc['name'],
        "day": userDoc['days'],
        "message": _messagecontroller.text,
        "Date": FieldValue.serverTimestamp()
      };
      await DatabaseMethods().addDay(dayinfo);
      Navigator.pop(context);
      await DatabaseMethods().updateDay();
    }
  }

  @override
  void dispose() {
    _messagecontroller.dispose();
    super.dispose();
  }

  final _messagecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
          child: Column(
            children: [
              const Text("Add What you did today"),
              TextField(
                controller: _messagecontroller,
                maxLength: 100,
                decoration: const InputDecoration(
                    label: Text("What did you did today?")),
              ),
              ElevatedButton(
                  onPressed: _submitData, child: const Text("Submit")),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
            ],
          )),
    );
  }
}
