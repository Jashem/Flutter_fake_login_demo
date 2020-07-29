import 'dart:io';

import "package:flutter/material.dart";
import 'package:image_picker/image_picker.dart';

typedef SetState = void Function(File state);

class ImagePickerModal extends StatelessWidget {
  final SetState setState;

  const ImagePickerModal({Key key, @required this.setState}) : super(key: key);

  Future _getImage(BuildContext context, ImageSource source) async {
    final picker = ImagePicker();

    var image =
        await picker.getImage(source: source, maxHeight: 300, maxWidth: 300);

    setState(File(image.path));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Wrap(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.camera),
              title: Text("Camera"),
              onTap: () => _getImage(context, ImageSource.camera),
            ),
            ListTile(
              leading: Icon(Icons.image),
              title: Text("Gallery"),
              onTap: () => _getImage(context, ImageSource.gallery),
            ),
            ListTile(
              leading: Icon(Icons.close),
              title: Text("Close"),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
