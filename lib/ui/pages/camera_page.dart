import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_vision/flutter_vision.dart';
import 'package:zero_waste_application/ui/styles/custom_theme.dart';

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
        useGpu: true);
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
    } else
      print('nothing found');

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
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: camLoading
          ? const Expanded(
              child: Center(child: CircularProgressIndicator()),
            )
          : Column(
              children: [
                img != null
                    ? Expanded(
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.file(
                              File(img.path),
                              fit: BoxFit.fitWidth,
                            ),
                            ...displayBoxesAroundRecognizedObjects(size)
                          ],
                        ),
                      )
                    : Expanded(
                        child: FutureBuilder(
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
                Padding(
                  padding: const EdgeInsets.all(13),
                  child: img == null
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(20),
                            backgroundColor: CustomTheme.color.background1,
                            foregroundColor: CustomTheme.color.base1,
                          ),
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
                          child: const Icon(Icons.circle_outlined),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(
                                  () {
                                    img = null;
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                padding: EdgeInsets.all(20),
                                backgroundColor: CustomTheme.color.background1,
                                foregroundColor: CustomTheme.color.base1,
                              ),
                              child: SizedBox(
                                height: 30,
                                width: 30,
                                child: Image.asset(
                                  "assets/images/icons/retake.png",
                                  color: CustomTheme.color.base1,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(
                                  () {},
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                padding: EdgeInsets.all(20),
                                backgroundColor: CustomTheme.color.background1,
                                foregroundColor: CustomTheme.color.base1,
                              ),
                              child: const SizedBox(
                                height: 30,
                                width: 30,
                                child: Icon(Icons.check),
                              ),
                            ),
                          ],
                        ),
                ),
              ],
            ),
    );
  }
}
