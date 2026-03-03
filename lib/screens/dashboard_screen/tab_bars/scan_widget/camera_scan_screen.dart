import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cocosmartapp/color_resources/color_resources.dart';
import 'package:flutter/material.dart';

class CameraScanScreen extends StatefulWidget {
  final String? scanType;
  const CameraScanScreen({super.key, this.scanType});

  @override
  State<CameraScanScreen> createState() => _CameraScanScreenState();
}

class _CameraScanScreenState extends State<CameraScanScreen> {
  CameraController? cameraController;
  List<CameraDescription> _cameras = [];
  String? imagePath;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      _cameras = await availableCameras();

      if (_cameras.isEmpty) {
        debugPrint('No cameras found');
        return;
      }

      cameraController = CameraController(
        _cameras.first,
        ResolutionPreset.max,
        enableAudio: false,
      );

      await cameraController!.initialize();

      if (!mounted) return;
      imagePath = null;
      setState(() {});
    } on CameraException catch (e) {
      debugPrint('Camera error: ${e.code} - ${e.description}');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (cameraController == null || !cameraController!.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded,color: Colors.white,)
        ),
        backgroundColor: ColorResources.MAIN_TEXT_COLOR,
        title: Text(widget.scanType == "disease"?'Disease Detection Test':'Nutrition Deficiency Test',style: TextStyle(fontWeight: FontWeight.w700,color: Colors.white),),
      ),
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        child: imagePath ==null?CameraPreview(
            cameraController!,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.sizeOf(context).height/4.8,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Center(
                child: InkWell(
                  onTap: (){
                    captureAndPreview();
                  },
                  child: Column(
                    children: [
                      SizedBox(height: 15,),
                      Text("Tap to capture",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white),),
                      SizedBox(height: 15,),
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: ColorResources.BUTTON_BACKGROUND_COLOR,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.camera_alt_rounded,color: Colors.white,size: 40,),
                      ),
                    ],
                  ),
                )
              ),
            ),
          ),
        ):Stack(
          fit: StackFit.expand,
          children: [
            Image.file(
              File(imagePath!),
              fit: BoxFit.cover,
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(Icons.close_rounded,color: Colors.white,),
                  onPressed: (){
                    setState(() {
                      _initCamera();
                    });
                  },
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: imagePath!=null?Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.scanType == "disease"?ColorResources.COLOR_PRIMARY:ColorResources.BUTTON_BACKGROUND_COLOR,
                padding: EdgeInsets.symmetric(horizontal: 50,vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                )
              ),
              onPressed: (){

              }, child: Text("Send To Scan",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16,color: Colors.white),)
          ),
        ),
      ):SizedBox(),
    );
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }

  Future<void> captureAndPreview() async {
    if (cameraController == null || !cameraController!.value.isInitialized) return;
    try {
      final XFile image = await cameraController!.takePicture();

      if(!mounted) return;
      setState(() {
        imagePath = image.path;
      });
      cameraController?.dispose();
      debugPrint('Picture saved to ${image.path}');
    } catch (e) {
      debugPrint('Capture error: $e');
    }
  }
}