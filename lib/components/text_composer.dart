import 'package:flutter/material.dart';

class TextComposer extends StatefulWidget {
  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  bool _isComposing = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.photo_camera),
        ),
        Expanded(
          child: TextField(
            decoration: InputDecoration.collapsed(hintText: 'Mensagem'),
            onChanged: (text) {
              setState(() {
                _isComposing = text.isNotEmpty;
              });
            },
            onSubmitted: (text) {},
          ),
        ),
        IconButton(onPressed: _isComposing ? () {} : null, icon: Icon(Icons.send))
      ],
    );
  }
}
