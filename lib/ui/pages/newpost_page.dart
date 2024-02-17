import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewPostPage extends StatefulWidget {
  const NewPostPage({super.key});

  @override
  State<NewPostPage> createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  final ImagePicker imagePicker = ImagePicker();
  XFile? image;

  Future getImage(ImageSource media) async {
    var img = await imagePicker.pickImage(source: media);
    setState(() {
      image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(child: Container()),
            ElevatedButton(
                onPressed: () {},
                child: const Row(
                  children: [
                    Text("POST"),
                    Icon(Icons.post_add),
                  ],
                )),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(label: Text("Write your title")),
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
            const TextField(
              decoration: InputDecoration(
                label: Text("Write your descriptions"),
              ),
              keyboardType: TextInputType.multiline,
              minLines: 15,
              maxLines: null,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        //to show image, you type like this.
                        File(image!.path),
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                      ),
                    )
                  : const Text(""),
            ),
            ElevatedButton(
              onPressed: () {
                getImage(ImageSource.gallery);
              },
              child: image != null
                  ? const Text("Change image")
                  : const Text("Add image"),
            ),
          ],
        ),
      ),
    );
  }
}
