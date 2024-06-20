import 'package:code_everyday/data.dart';
import 'package:code_everyday/message.dart';
import 'package:code_everyday/messageform.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void openForm() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: const MessageForm(),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Welcome  👋'),
          actions: [
            IconButton(
              onPressed: openForm,
              icon: const Icon(Icons.add),
              iconSize: 30,
            )
          ],
        ),
        body: ListView.builder(
          itemCount: messages.length,
          itemBuilder: (BuildContext context, int index) {
            return Message(
              message: messages[index],
            );
          },
        ));
  }
}
