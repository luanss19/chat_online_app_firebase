import 'dart:io';

import 'package:chat_online_app_firebase/components/text_composer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Future<void> _sendMessage({String? text, XFile? imgFile}) async {
    Map<String, dynamic> data = {};

    if (imgFile != null) {
      FirebaseStorage storage = FirebaseStorage.instance;
      String? url;
      Reference ref = storage
          .ref()
          .child('imagens')
          .child("image" + DateTime.now().toString());

      TaskSnapshot task =
          await ref.putFile(File(imgFile.path)).whenComplete((){});
      url = await task.ref.getDownloadURL();
      data['imgUrl'] = url;

    }

    if (text != null) data['text'] = text;

    FirebaseFirestore.instance.collection('messages').add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Name'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:  FirebaseFirestore.instance.collection('messages').snapshots(),
              builder: (context, snapshot){
                switch(snapshot.connectionState){
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  default:
                    List<DocumentSnapshot> documents = snapshot.data!.docs.reversed.toList();
                    return ListView.builder(
                        itemCount: documents.length,
                        reverse: true,
                        itemBuilder: (context,index){
                          return ListTile(
                            title: Text(documents[index]['text']),
                          );
                        }
                        );
                }
              },
            ),
          ),
          TextComposer(_sendMessage),
        ],
      ),
    );
  }
}
