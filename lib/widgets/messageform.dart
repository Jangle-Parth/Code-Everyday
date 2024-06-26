import 'dart:math';

import 'package:code_everyday/data/messagemodel.dart';
import 'package:code_everyday/firebase/database.dart';
import 'package:flutter/material.dart';

class MessageForm extends StatefulWidget {
  const MessageForm({super.key});

  @override
  State<MessageForm> createState() => _MessageFormState();
}

class _MessageFormState extends State<MessageForm> {
  void _submitData() {
    if (_messagecontroller.text.isEmpty) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Invalid Input'),
                content:
                    const Text("Please Make sure you have added your message"),
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
        "name": "Jangle Parth",
        "day": "${Random().nextInt(100)}",
        "message": _messagecontroller.text
      };

      DatabaseMethods().addDay(dayinfo, "${Random().nextInt(100)}");
      Navigator.pop(context);
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
