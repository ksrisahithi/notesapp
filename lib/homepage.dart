import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/add_note.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_app/login_page.dart';
import 'viewnote.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  CollectionReference ref = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).collection('notes');


  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

  int numberOfCards() {
    if(w >= 1080) {
      return 4;
    }
    if(w > 760) {return 2;}
    return 1;
  }

  double screenPadding() {
    if(w <= 420) {
      return 0;
    }
    else if(w > 760 && w < 1080) {
      return 100;
    }
    else {return 200;}
  }

  double adaptiveText(double value) {
    return (value/720)*h;
  }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Notes'),
        centerTitle: true,
        leading: IconButton(onPressed: () {
            Get.to(LoginPage());
        }, icon: const Icon(Icons.arrow_back_outlined)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddNote())!
              .then((value) {
            setState(() {});
          });
        },
        backgroundColor: Colors.blue[900],
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Center(
        child: SizedBox(
          child: FutureBuilder<QuerySnapshot>(
            future: ref.get(),
            builder: (context,AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.docs.length == 0) {
                  return const Center(
                    child: Text(
                      "You have no saved Notes !",
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  );
                }
                return Padding(
                  padding: EdgeInsets.only(
                    left: screenPadding(), top: 8, bottom: 8, right: screenPadding()
                  ),
                  child: GridView.builder(
                     gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: numberOfCards(),
                      childAspectRatio: 3/2,
                    ),
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      Map data = snapshot.data.docs[index].data();
                      return Card(
                        color: Colors.pink[300],
                        child: InkWell(
                          onTap: () {
                            Get.to(ViewNote(data,
                                  snapshot.data.docs[index].reference,))!
                                .then((value) {
                              setState(() {});
                            });
                          },
                          child: SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${data['title']}",
                                  style: TextStyle(
                                    fontSize: adaptiveText(24),
                                    fontFamily: "Karla",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                
                                Expanded(
                                  child: Text(
                                    "${data['description']}",
                                    style: TextStyle(
                                      fontSize: adaptiveText(24)*(5/6),
                                      fontFamily: "Karla",
                                      color: Colors.black87,
                                    ),
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                              ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return const Center(
                  child: Text("Loading..."),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}