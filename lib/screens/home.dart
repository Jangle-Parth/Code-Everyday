import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_everyday/data/messagemodel.dart';
import 'package:code_everyday/firebase/database.dart';
import 'package:code_everyday/widgets/message.dart';
import 'package:code_everyday/widgets/messageform.dart';
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

  Stream? DayStream;
  getontheload() async {
    DayStream = await DatabaseMethods().getDays();
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: DayStream,
        builder: (context, snapshot) {
          return Scaffold(
              appBar: AppBar(
                title: const Text('Welcome 👋'),
                actions: [
                  IconButton(
                    onPressed: openForm,
                    icon: const Icon(Icons.add),
                    iconSize: 30,
                  )
                ],
              ),
              body: snapshot.hasData
                  ? ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        DocumentSnapshot doc = snapshot.data.docs[index];
                        return Message(
                          message: MessageModel(
                              day: doc['day'],
                              message: doc['message'],
                              name: doc['name']),
                        );
                      },
                    )
                  : const Center(
                      child: Text("Aarambh"),
                    ));
        });
  }
}
