import 'dart:io';
import 'package:accuron/view/camera_screen/show_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  ImagePicker picker = ImagePicker();
  List<String> imageList = [];

  Future<void> takePicture() async {
    final image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        imageList.add(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.camera),
              onPressed: takePicture,
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 3,
                  mainAxisSpacing: 3,
                ),
                itemBuilder: (ctx, index) {
                  return InkWell(
                    child: Image.file(
                      File(imageList[index]), 
                      fit: BoxFit.fill,
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ShowImage(
                          image: imageList[index],
                          index: index,
                        ),
                      ));
                    },
                  );
                },
                itemCount: imageList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
