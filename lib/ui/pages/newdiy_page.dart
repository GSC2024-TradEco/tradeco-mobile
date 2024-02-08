import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class NewDiyPage extends StatefulWidget {
  const NewDiyPage({super.key, required this.cam});
  final CameraDescription cam;

  @override
  State<NewDiyPage> createState() => _NewDiyPageState();
}

class _NewDiyPageState extends State<NewDiyPage> {
  late CameraController _cameraController;
  late Future<void> _initCameraController;
  dynamic img;
  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(widget.cam, ResolutionPreset.medium);
    _initCameraController = _cameraController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New Project")),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: double.infinity,
                maxHeight: 400,
              ),
              child: img != null
                  ? Image.file(File(img.path))
                  : FutureBuilder(
                      future: _initCameraController,
                      builder: (context, snapshoot) {
                        if (snapshoot.connectionState == ConnectionState.done) {
                          return CameraPreview(_cameraController);
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
            ),
            ElevatedButton(
                onPressed: () async {
                  print("cekrek");
                  try {
                    await _initCameraController;
                    img = await _cameraController.takePicture();
                    setState(() {});
                  } catch (e) {
                    print(e);
                  }
                },
                child: Text("Take picture")),
            const SizedBox(height: 5),
            const Text("List Items"),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    child: Text("Item $index"),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 8);
                },
                itemCount: 3,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Share Waste"),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Get Project Suggestion"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
