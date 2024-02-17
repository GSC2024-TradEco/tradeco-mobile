import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zero_waste_application/controllers/post.dart';

class NewPostPage extends StatefulWidget {
  const NewPostPage({super.key});

  @override
  State<NewPostPage> createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  PostController postController = PostController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
              onPressed: () async {
                String title = titleController.text;
                String description = descriptionController.text;
                String? token = await _auth.currentUser!.getIdToken(true);
                Map<String, dynamic>? post = await postController.createOnePost(
                    title, description, token!);
                if (post != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Post created successfully'),
                    ),
                  );
                  Navigator.of(context).pop();
                }
              },
              child: const Row(
                children: [
                  Text("POST"),
                  Icon(Icons.post_add),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration:
                  const InputDecoration(label: Text("Write your title")),
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
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
