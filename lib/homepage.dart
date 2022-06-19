import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/add_note.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_app/login_page.dart';
import 'viewnote.dart';
import 'dart:math';
import 'package:intl/intl.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  CollectionReference ref = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).collection('notes');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Notes'),
        centerTitle: true,
        leading: IconButton(onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
        }, icon: Icon(Icons.arrow_back_outlined)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => AddNote(),
            ),
          )
              .then((value) {
            print("Calling Set  State !");
            setState(() {});
          });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue[900],
      ),
      body: Center(
        child: SizedBox(
          child: FutureBuilder<QuerySnapshot>(
            future: ref.get(),
            builder: (context,AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.docs.length == 0) {
                  return Center(
                    child: Text(
                      "You have no saved Notes !",
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  );
                }

                return GridView.builder(
                   gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                  ),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    Map data = snapshot.data.docs[index].data();
                    return Card(
                      color: Colors.pink[300],
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(
                            MaterialPageRoute(
                              builder: (context) => ViewNote(
                                data,
                                snapshot.data.docs[index].reference,
                              ),
                            ),
                          )
                              .then((value) {
                            setState(() {});
                          });
                        },
                        child: SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${data['title']}",
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontFamily: "Karla",
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              
                              Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "${data['description']}",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: "Karla",
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Center(
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