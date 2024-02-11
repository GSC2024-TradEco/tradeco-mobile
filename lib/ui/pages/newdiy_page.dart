import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vision/flutter_vision.dart';

class NewDiyPage extends StatefulWidget {
  const NewDiyPage({super.key, required this.cam});
  final CameraDescription cam;

  @override
  State<NewDiyPage> createState() => _NewDiyPageState();
}

class _NewDiyPageState extends State<NewDiyPage> {
  late CameraController _cameraController;
  late Future<void> _initCameraController;
  late FlutterVision vision;
  List<dynamic> yoloResults = [];
  bool camLoading = false;
  dynamic img;
  int imageHeight = 1;
  int imageWidth = 1;

  @override
  void initState() {
    super.initState();
    vision = FlutterVision();
    _cameraController = CameraController(widget.cam, ResolutionPreset.medium);
    _initCameraController = _cameraController.initialize().then((value) {
      setState(() {
        loadYoloModel();
      });
    });
  }

  @override
  void dispose() async {
    super.dispose();
    await vision.closeYoloModel();
  }

  Future<void> loadYoloModel() async {
    await vision.loadYoloModel(
        labels: 'assets/label.txt',
        modelPath: 'assets/model.tflite',
        modelVersion: "yolov8",
        quantization: false,
        numThreads: 1,
        useGpu: false);
  }

  _detectObject(File img) async {
    print("DETECT OBJECT");
    yoloResults.clear();
    Uint8List byte = await img.readAsBytes();
    final image = await decodeImageFromList(byte);
    imageHeight = image.height;
    imageWidth = image.width;
    final result = await vision.yoloOnImage(
        bytesList: byte,
        imageHeight: image.height,
        imageWidth: image.width,
        iouThreshold: 0.05,
        confThreshold: 0.05,
        classThreshold: 0.05);
    if (result.isNotEmpty) {
      setState(() {
        yoloResults = result;
        print(yoloResults);
      });
    }

    print("DETECT FINISH");
  }

  List<Widget> displayBoxesAroundRecognizedObjects(Size screen) {
    print("DISPLAYYYY");
    if (yoloResults.isEmpty) return [];

    double factorX = screen.width / (imageWidth);
    double imgRatio = imageWidth / imageHeight;
    double newWidth = imageWidth * factorX;
    double newHeight = newWidth / imgRatio;
    double factorY = newHeight / (imageHeight);

    double pady = (screen.height - newHeight) / 2;

    Color colorPick = const Color.fromARGB(255, 50, 233, 30);
    return yoloResults.map((result) {
      return Positioned(
        left: result["box"][0] * factorX,
        top: result["box"][1] * factorY + pady,
        width: (result["box"][2] - result["box"][0]) * factorX,
        height: (result["box"][3] - result["box"][1]) * factorY,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(color: Colors.pink, width: 2.0),
          ),
          child: Text(
            "${result['tag']} ${(result['box'][4] * 100).toStringAsFixed(0)}%",
            style: TextStyle(
              background: Paint()..color = colorPick,
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text("New Project")),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            camLoading
                ? const SizedBox(
                    height: 450,
                    width: double.infinity,
                    child: Center(child: CircularProgressIndicator()),
                  )
                : Column(
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          minWidth: double.infinity,
                          minHeight: 400,
                          maxHeight: 400,
                        ),
                        child: img != null
                            ? Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.file(
                                    width: double.infinity,
                                    height: 400,
                                    File(img.path),
                                    fit: BoxFit.fill,
                                  ),
                                  ...displayBoxesAroundRecognizedObjects(
                                    Size(200, 400),
                                  )
                                ],
                              )
                            : FutureBuilder(
                                future: _initCameraController,
                                builder: (context, snapshoot) {
                                  if (snapshoot.connectionState ==
                                      ConnectionState.done) {
                                    return CameraPreview(_cameraController);
                                  } else {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                },
                              ),
                      ),
                      img == null
                          ? ElevatedButton(
                              onPressed: () async {
                                try {
                                  await _initCameraController;
                                  img = await _cameraController.takePicture();
                                  setState(() {
                                    camLoading = true;
                                  });
                                  File imgTarget = File(img.path);
                                  _detectObject(imgTarget);
                                  setState(() {
                                    camLoading = false;
                                  });
                                } catch (e) {
                                  print(e);
                                }
                              },
                              child: const Text("Take picture"),
                            )
                          : ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  img = null;
                                });
                              },
                              child: const Text("Retake"),
                            ),
                    ],
                  ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("List Items"),
                ElevatedButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.add),
                        Text("Add"),
                      ],
                    ))
              ],
            ),
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
