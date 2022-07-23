import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class ImageField extends StatefulWidget {
  final Function selectImage;

  const ImageField({Key? key, required this.selectImage}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return ImageFieldState();
  }
}

class ImageFieldState extends State<ImageField> {
  XFile? imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> addImageToFile(
    ImageSource source,
  ) async {
    XFile? a;
    a = await _picker.pickImage(source: source, maxWidth: 1280);
    widget.selectImage(a!);
    setState(() {
      imageFile = a;
    });
  }

  Widget _buildPickImageButton(double width, context) {
    return SizedBox(
        width: width,
        child: OutlinedButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              FaIcon(
                FontAwesomeIcons.cameraRetro,
                size: 20,
              ),
              SizedBox(
                width: 10,
              ),
              Text("Pick an image")
            ],
          ),
          onPressed: () => _showButtonSheet(context),
        ));
  }

  void _showButtonSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
              padding: const EdgeInsets.all(10.0),
              height: 200.0,
              child: Column(children: [
                const Text(
                  "Pick an image",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20.0),
                TextButton(
                    onPressed: () async {
                      await addImageToFile(ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                    child: const Text("Pick from camera")),
                const SizedBox(height: 10.0),
                TextButton(
                    onPressed: () async {
                      await addImageToFile(ImageSource.gallery);
                      Navigator.of(context).pop();
                    },
                    child: const Text(" Pick from device "))
              ]));
        });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double tagetPadding = width > 600 ? width / 2 / 2 : width / 5 / 2;
    return Column(
      children: [
        _buildPickImageButton(width - tagetPadding, context),
        const SizedBox(
          height: 10.5,
        ),
        imageFile == null
            ? const Text(
                "Please pick an image if avaliable",
                style: TextStyle(color: Colors.red),
              )
            : Image.file(
                File(imageFile!.path),
                height: 400,
                width: MediaQuery.of(context).size.width / 1.2,
                alignment: Alignment.topCenter,
                fit: BoxFit.cover,
              ),
      ],
    );
  }
}
