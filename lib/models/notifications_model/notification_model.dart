import 'package:intl/intl.dart';

class NotificationModel{
  String? title;
  String? body;
  DateTime? timeStamp;

  NotificationModel({required this.body,required this.timeStamp,required this.title});

  NotificationModel.fromJson(Map<String,dynamic> json){
    title = json['title'];
    body = json['body'];
    timeStamp = DateTime.tryParse(json['timestamp']);
  }


}