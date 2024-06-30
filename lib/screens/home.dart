import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_everyday/data/messagemodel.dart';
import 'package:code_everyday/firebase/database.dart';
import 'package:code_everyday/screens/leaderboardscreen.dart';
import 'package:code_everyday/screens/profilescreen.dart';
import 'package:code_everyday/screens/searchscreen.dart';
import 'package:code_everyday/widgets/message.dart';
import 'package:code_everyday/widgets/messageform.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

Future getUserData() async {
  DocumentSnapshot userDoc = await FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .get();
  return userDoc;
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
  int pageindex = 0;
  List screens = [
    const SearchScreen(),
    const LeaderBoardScreen(),
    const ProfileScreen(),
  ];
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
              appBar: pageindex == 0
                  ? AppBar(
                      title: const Text('Welcome 👋'),
                      actions: [
                        IconButton(
                          onPressed: openForm,
                          icon: const Icon(Icons.add),
                          iconSize: 30,
                        )
                      ],
                    )
                  : null,
              bottomNavigationBar: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  currentIndex: pageindex,
                  selectedItemColor: Colors.blue,
                  unselectedItemColor: Colors.grey,
                  onTap: (index) {
                    setState(() {
                      pageindex = index;
                    });
                  },
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: "Home",
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.search), label: "Search"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.leaderboard), label: "LeaderBoard"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.account_circle), label: "Profile"),
                  ]),
              body: pageindex == 0
                  ? snapshot.hasData
                      ? ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            DocumentSnapshot doc = snapshot.data.docs[index];
                            return Message(
                              message: MessageModel(
                                  day: "${doc['day']}",
                                  message: doc['message'],
                                  name: doc['name']),
                            );
                          },
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        )
                  : screens[pageindex - 1]);
        });
  }
}
