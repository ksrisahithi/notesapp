import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {

  String title = '';
  String des = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_outlined),
          ),
          actions: [
            IconButton(onPressed: add, icon: const Icon(Icons.save))
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width*0.75,
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                const SizedBox(height: 12,),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration.collapsed(hintText: 'Title'),
                        style: const TextStyle(
                          fontSize: 32,
                          fontFamily: 'SecularOne',
                          color: Colors.grey,
                        ),
                        onChanged: (val) {
                          title = val;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration.collapsed(hintText: 'description'),
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Karla',
                          color: Colors.grey,
                        ),
                        onChanged: (val) {
                          des = val;
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void add() {
    CollectionReference ref = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).collection('notes');
  
 Map<String, String> data = {
    'title' : title,
    'description' : des,

  };

  ref.add(data);

  Get.back();


  }

}