import 'package:cocosmartapp/color_resources/color_resources.dart';
import 'package:cocosmartapp/models/notifications_model/notification_model.dart';
import 'package:cocosmartapp/provider/notification_provider/notification_provider.dart';
import 'package:cocosmartapp/screens/notification_screen/widget/notification_card.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback){
      Provider.of<NotificationProvider>(context,listen: false).getNotification();
    });

  }

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
      body: Consumer<NotificationProvider>(
        builder: (BuildContext context, NotificationProvider notification_provider, Widget? child) {
          return notification_provider.isNotificationLoading? Center(child: LoadingAnimationWidget.fourRotatingDots(color: ColorResources.MAIN_TEXT_COLOR, size: 35))
              :notification_provider.notifications.isNotEmpty?ListView.builder(
            itemCount: notification_provider.notifications.length,
              itemBuilder: (context,index){
              NotificationModel notification = notification_provider.notifications.elementAt(index);
              return NotificationCard(title: notification.title, body: notification.body, timeStamp: notification.timeStamp,);
              }
          ):Container(
          decoration: BoxDecoration(
          color: ColorResources.MAIN_BACKGROUND_COLOR
          ),
          child: Center(
          child: Text("No new notifications"),
          ),
          );
        },
      ),
    );
  }
}
