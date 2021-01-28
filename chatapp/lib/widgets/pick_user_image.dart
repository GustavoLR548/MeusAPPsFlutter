import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickUserImage extends StatefulWidget {
  final void Function(File pickedImage) sendImageData;
  PickUserImage(this.sendImageData);

  @override
  _PickUserImageState createState() => _PickUserImageState();
}

class _PickUserImageState extends State<PickUserImage> {
  File _pickedImage;

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(
        source: ImageSource.camera,
        imageQuality: 80,
        maxHeight: 150,
        maxWidth: 150);
    if (pickedImage == null) return;
    final pickedImageFile = File(pickedImage.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    widget.sendImageData(_pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CircleAvatar(
        radius: 50,
        backgroundColor: Colors.grey,
        backgroundImage: _pickedImage == null ? null : FileImage(_pickedImage),
      ),
      FlatButton.icon(
        textColor: Theme.of(context).primaryColor,
        onPressed: _pickImage,
        icon: Icon(Icons.image),
        label: Text('Add Image'),
      )
    ]);
  }
}
