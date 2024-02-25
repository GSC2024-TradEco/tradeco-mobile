import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zero_waste_application/controllers/post.dart';
import 'package:zero_waste_application/ui/styles/custom_theme.dart';

class NewPostPage extends StatefulWidget {
  const NewPostPage({Key? key}) : super(key: key);

  @override
  State<NewPostPage> createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  PostController postController = PostController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final ImagePicker imagePicker = ImagePicker();
  File? image;
  bool isPosting = false;

  Future<void> postAction() async {
    setState(() {
      isPosting = true;
    });

    String title = titleController.text;
    String description = descriptionController.text;
    String? token = await _auth.currentUser!.getIdToken(true);
    bool post = await postController.createOnePost(
      title,
      description,
      image,
      token!,
    );

    setState(() {
      isPosting = false;
    });

    if (post == true) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Post Created'),
            content: const Text('The post has been successfully created.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop(true);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Post Failed'),
            content: const Text('The post failed to create.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop(false);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> getImage(ImageSource media) async {
    final XFile? img = await imagePicker.pickImage(source: media);
    File file = File(img!.path);
    setState(() {
      image = file;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            Text(
              "Create Post",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.normal,
              ),
            ),
            Expanded(child: Container()),
            ElevatedButton(
              onPressed: () async {
                await postAction();
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: CustomTheme.color.base2,
                foregroundColor: Colors.black,
              ),
              child: Row(
                children: [
                  Text("POST"),
                  Icon(Icons.post_add),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: CustomTheme.color.gradientBackground1,
              ),
            ),
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    label: Text("Write your title"),
                    border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    fillColor: CustomTheme.color.background1,
                    filled: true,
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
                SizedBox(height: 7),
                Expanded(
                  child: TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      label: Text("Write your descriptions"),
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fillColor: CustomTheme.color.background1,
                      filled: true,
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            File(image!.path),
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                            height: 300,
                          ),
                        )
                      : Text(""),
                ),
                ElevatedButton(
                  onPressed: () {
                    getImage(ImageSource.gallery);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomTheme.color.base2,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: SizedBox(
                    width: 100,
                    height: 45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          "assets/images/icons/upload-photo.png",
                          height: 24,
                          width: 24,
                        ),
                        image != null
                            ? Text("Change image")
                            : Text("Add image"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isPosting)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
