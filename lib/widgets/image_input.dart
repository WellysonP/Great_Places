import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  const ImageInput(this.onSelectImage, {Key? key}) : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storeImage;

  _takePicture() async {
    final ImagePicker _picker = ImagePicker();
    XFile imageFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    ) as XFile;

    setState(() {
      _storeImage = File(imageFile.path);
    });

    //diretorio para armazenar imagem...
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    String fileName = path.basename(_storeImage!.path);
    final savedImage = await _storeImage!.copy("${appDir.path}/$fileName");

    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 180,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          alignment: Alignment.center,
          child: _storeImage == null
              ? Text("Nenhuma Imagem!")
              : Image.file(
                  _storeImage!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: FlatButton.icon(
            onPressed: _takePicture,
            icon: Icon(Icons.camera),
            label: Text("Tirar Foto"),
            textColor: Theme.of(context).colorScheme.primary,
          ),
        )
      ],
    );
  }
}
