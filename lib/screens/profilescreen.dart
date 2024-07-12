import 'package:code_everyday/firebase/database.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => DatabaseMethods().signOut(),
            ),
          ],
        ),
        body: StreamBuilder(
            stream: DatabaseMethods().getUserStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return const Text('Error loading user data');
              } else if (snapshot.hasData) {
                var userData = snapshot.data!.data() as Map<String, dynamic>;
                return Column(children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Center(
                    child: Column(
                      children: [
                        const CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/default_profile.jpg"),
                          radius: 80,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          userData["name"],
                          style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            userData["headline"] ?? "Not Found",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 80,
                          width: 220,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 186, 215, 255),
                            border: const Border(
                              bottom: BorderSide(
                                  color: Color.fromARGB(255, 112, 95, 226),
                                  width: 3),
                              top: BorderSide(
                                  color: Color.fromARGB(255, 112, 95, 226),
                                  width: 3),
                              right: BorderSide(
                                  color: Color.fromARGB(255, 112, 95, 226),
                                  width: 3),
                              left: BorderSide(
                                  color: Color.fromARGB(255, 112, 95, 226),
                                  width: 3),
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                "Total No of Days: ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                " ${userData["days"]}",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 80,
                          width: 220,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 186, 215, 255),
                            border: const Border(
                              bottom: BorderSide(
                                  color: Color.fromARGB(255, 112, 95, 226),
                                  width: 3),
                              top: BorderSide(
                                  color: Color.fromARGB(255, 112, 95, 226),
                                  width: 3),
                              right: BorderSide(
                                  color: Color.fromARGB(255, 112, 95, 226),
                                  width: 3),
                              left: BorderSide(
                                  color: Color.fromARGB(255, 112, 95, 226),
                                  width: 3),
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Column(
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Max Day Streak: ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "5",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 80,
                          width: 220,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 186, 215, 255),
                            border: const Border(
                              bottom: BorderSide(
                                  color: Color.fromARGB(255, 112, 95, 226),
                                  width: 3),
                              top: BorderSide(
                                  color: Color.fromARGB(255, 112, 95, 226),
                                  width: 3),
                              right: BorderSide(
                                  color: Color.fromARGB(255, 112, 95, 226),
                                  width: 3),
                              left: BorderSide(
                                  color: Color.fromARGB(255, 112, 95, 226),
                                  width: 3),
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                "Current Rank: ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "${userData["rank"]}",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ]);
              } else {
                return const Text('No user data available');
              }
            }));
  }
}
