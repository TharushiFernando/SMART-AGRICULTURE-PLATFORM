import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cocosmartapp/models/land_model/land_model.dart';
import 'package:cocosmartapp/provider/disease_provider/disease_provider.dart';
import 'package:cocosmartapp/provider/estate_provider/land_provider.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../../../color_resources/color_resources.dart';

class SendImageResult extends StatefulWidget {
  String? imageFilePath;
  final String? scanType;
  SendImageResult({super.key,required this.imageFilePath,required this.scanType});

  @override
  State<SendImageResult> createState() => _SendImageResultState();
}

class _SendImageResultState extends State<SendImageResult> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<LandProvider,DiseaseProvider>(
      builder: (BuildContext context, LandProvider land_provider,DiseaseProvider disease_provider, Widget? child) {
        return Container(
          width: MediaQuery.sizeOf(context).width,
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: FileImage(
                        File(widget.imageFilePath??''),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                Text("Yellow Leaf Disease",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.black),),
                SizedBox(height: 5,),
                Text("The yellow leaf disease is a common plant ailment that affects various crops, including tomatoes, peppers, and citrus trees. It is characterized by the yellowing of leaves, which can lead to reduced photosynthesis and overall plant health. The disease is often caused by nutrient deficiencies, particularly nitrogen, or by viral infections transmitted by pests such as aphids. To manage yellow leaf disease, it is essential to identify the underlying cause and implement appropriate measures, such as improving soil fertility, controlling pests, and using resistant plant varieties.",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),
                SizedBox(height: 40,),
                widget.scanType == "disease"?SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:ColorResources.COLOR_PRIMARY,
                          padding: EdgeInsets.symmetric(horizontal: 50,vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          )
                      ),
                      onPressed: (){
                        LandModel? land = land_provider.lands?.elementAt(0);
                        disease_provider.sendFarmerNotification("Warning", "Yellow Leaf Disease Detected", land?.lat??0.0, land?.lng??0.0).then((onValue){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.green,
                                content: Text("Nearby farmers have been notified about the detected disease.")),
                          );
                        });
                      },
                      child: (disease_provider.isSendingNotification??false)?LoadingAnimationWidget.fourRotatingDots(color: Colors.white, size: 25):Text("Notify Nearby Farmers",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16,color: Colors.white),)
                  ),
                ):SizedBox(),
                SizedBox(height: 40,),
              ],
            ),
          ),
        );
      },
    );
  }
}
