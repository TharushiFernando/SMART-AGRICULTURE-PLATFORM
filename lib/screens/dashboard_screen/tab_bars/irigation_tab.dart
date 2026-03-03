import 'package:cocosmartapp/color_resources/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IrigationTab extends StatefulWidget {
  const IrigationTab({super.key});

  @override
  State<IrigationTab> createState() => _IrigationTabState();
}

class _IrigationTabState extends State<IrigationTab> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Center(child: Text("Next Recommended Watering",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: ColorResources.MAIN_TEXT_COLOR),)),
        SizedBox(height: 20,),
        Center(child: Text("${DateFormat('EEEE, MMM d').format(DateTime.now())}",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w800,color: ColorResources.MAIN_TEXT_COLOR),)),
        SizedBox(height: 20,),
        Icon(Icons.water_drop,color: ColorResources.COLOR_PRIMARY,size: 80,),
        SizedBox(height: 10,),
        Center(child: Text("Recommended Amount",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: ColorResources.MAIN_TEXT_COLOR),)),
        SizedBox(height: 5,),
        Center(child: Text("500 Liters",style: TextStyle(fontSize: 35,fontWeight: FontWeight.w800,color: ColorResources.MAIN_TEXT_COLOR),)),
        Center(child: Text("Per Zone",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: ColorResources.MAIN_TEXT_COLOR),)),
        SizedBox(height: 40,),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: ColorResources.BUTTON_BACKGROUND_COLOR,
                padding: EdgeInsets.symmetric(horizontal: 50,vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                )
            ),
            onPressed: (){

            },
            child: Text("Set Reminder",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w700),)
        ),
        SizedBox(height: 10,),
        TextButton(
            onPressed: (){

            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.refresh_rounded,size: 30,color: ColorResources.MAIN_TEXT_COLOR,),
                SizedBox(width: 10,),
                Text("Recalculate Recommendation",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: ColorResources.MAIN_TEXT_COLOR),)
              ],
            ),
        ),
      ],
    );
  }
}
