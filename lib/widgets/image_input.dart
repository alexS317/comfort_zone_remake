import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// Image input allows to select an image from the gallery and preview it
class ImageInput extends StatefulWidget {
  // Input a new image (default)
  const ImageInput({super.key, required this.onPickImage}) : oldImage = null ;

  // // Edit variant: preview an old image to swap it with a new one
  // const ImageInput.edit({super.key, required this.onPickImage, required this.oldImage});

  final void Function(File image) onPickImage;
  final File? oldImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    // If there is an old image provided, use it for the initial preview
    if (widget.oldImage != null) _selectedImage = widget.oldImage;
  }

  // Choose a picture from the gallery and preview it in the input
  void _choosePicture() async {
    // Open gallery and pick an image
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 25);

    // If no image was picked, do nothing
    if (pickedImage == null) return;

    // Set the image preview to the picked image
    setState(() {
      _selectedImage = File(pickedImage.path);
    });

    // Set selected image as function parameter
    widget.onPickImage(_selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    // Empty preview
    Widget content = const SizedBox(
      height: 300,
      child: FittedBox(
        child: Icon(Icons.image),
      ),
    );

    // Chosen image preview
    if (_selectedImage != null) {
      content = Image.file(_selectedImage!);
    }

    return GestureDetector(
      onTap: _choosePicture,
      child: content,
    );
  }
}
