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

    if(imgFile != null){
      FirebaseStorage storage = FirebaseStorage.instance;
      String? url;
      Reference ref = storage.ref().child('imagens').child("image" + DateTime.now().toString());
      UploadTask task = ref.putFile(File(imgFile.path));


      task.whenComplete(() async{
        url = await ref.getDownloadURL();
      });
      print('URL ABAIXO');
      print(url);
    }
        FirebaseFirestore.instance.collection('messages').add({
          'text':text
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Name'),
        elevation: 0,
      ),
      body: TextComposer(_sendMessage),
    );
  }
}
