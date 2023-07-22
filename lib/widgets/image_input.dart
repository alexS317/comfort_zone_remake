import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;

  // Choose a picture from the gallery and preview it in the input
  void _choosePicture() async {
    // Open gallery and pick an image
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage == null) return;  // If no image was picked, do nothing

    // Set the image preview to the picked image
    setState(() {
      _selectedImage = File(pickedImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const SizedBox(
      height: 300,
      child: FittedBox(
        child: Icon(Icons.image),
      ),
    );

    if (_selectedImage != null) {
      content = Image.file(_selectedImage!);
    }

    return GestureDetector(
      onTap: _choosePicture,
      child: content,
    );
  }
}
