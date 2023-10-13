import 'dart:io';
import 'package:flutter/material.dart';


class ShowImage extends StatefulWidget {
  const ShowImage({Key? key, required this.image, required this.index})
      : super(key: key);
  final String image;
  final int index;
  @override
  State<ShowImage> createState() => _ShowImageState();
}

class _ShowImageState extends State<ShowImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  width: 500,
                  height: 600,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10)),
                  child: Image.file(File(widget.image)),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    delete(widget.index);
                  },
                  icon: const Icon(Icons.delete),
                  label: const Text('Delete'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void delete(index) async {
    
  }

  
}
