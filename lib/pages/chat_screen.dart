import 'package:chat_online_app_firebase/components/text_composer.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Name'),
        elevation: 0,
      ),
      body: TextComposer(),
    );
  }
}
