import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TextComposer extends StatefulWidget {

  TextComposer(this.sendMessage);

  final Function({String? text, XFile? imgFile}) sendMessage;

  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  bool _isComposing = false;
  final TextEditingController _controller = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  void _reset(){
    _controller.clear();
    setState(() {
      _isComposing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () async {
              final XFile? imgFile = (await _picker.pickImage(source: ImageSource.camera));
              if (imgFile == null) return;
              widget.sendMessage(imgFile: imgFile);
            },
            icon: const Icon(Icons.photo_camera),
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              style: TextStyle(color: Colors.white),
              decoration: const InputDecoration.collapsed(
                  hintText: 'Mensagem',
                  hintStyle: TextStyle(color: Colors.white)),
              onChanged: (text) {
                setState(() {
                  _isComposing = text.isNotEmpty;
                });
              },
              onSubmitted: (message) {
                widget.sendMessage(text: message);
                _reset();
              },
            ),
          ),
          IconButton(
            disabledColor: Colors.white24,
            onPressed: _isComposing ? () {
              FocusScope.of(context).unfocus();
              widget.sendMessage(text: _controller.text);
              _reset();
            } : null,
            icon: const Icon(Icons.send),
          )
        ],
      ),
    );
  }
}
