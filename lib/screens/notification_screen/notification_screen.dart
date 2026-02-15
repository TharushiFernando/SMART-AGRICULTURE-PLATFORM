import 'package:cocosmartapp/color_resources/color_resources.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded,color: Colors.white,)
        ),
        backgroundColor: ColorResources.MAIN_TEXT_COLOR,
        title: Text("Notifications",style: TextStyle(fontWeight: FontWeight.w700,color: Colors.white),),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: ColorResources.MAIN_BACKGROUND_COLOR
        ),
        child: Center(
          child: Text("No new notifications"),
        ),
      ),
    );
  }
}
