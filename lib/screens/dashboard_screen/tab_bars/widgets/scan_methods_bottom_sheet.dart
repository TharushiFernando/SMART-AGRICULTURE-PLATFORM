import 'package:cocosmartapp/color_resources/color_resources.dart';
import 'package:cocosmartapp/screens/dashboard_screen/tab_bars/scan_widget/camera_scan_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ScanMethodsBottomSheet extends StatefulWidget {
  const ScanMethodsBottomSheet({super.key});

  @override
  State<ScanMethodsBottomSheet> createState() => _ScanMethodsBottomSheetState();
}

class _ScanMethodsBottomSheetState extends State<ScanMethodsBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("Select Scan Method",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: ColorResources.MAIN_TEXT_COLOR),),
              Spacer(),
              IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close_rounded,color: Colors.grey.shade700,size: 30,),
              )
            ],
          ),
          SizedBox(height: 15,),
          ListTile(
            leading: Icon(Icons.local_hospital_outlined,size: 30,color: ColorResources.COLOR_PRIMARY,),
            title: Text("Crop Disease Detection",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.grey.shade700),),
            onTap: (){
              Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop,child: CameraScanScreen(scanType: "disease",)));
            },
          ),
          ListTile(
            leading: Icon(Icons.wind_power_rounded,size: 30,color: ColorResources.BUTTON_BACKGROUND_COLOR,),
            title: Text("Crop Nutrition Deficiency Detection",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.grey.shade700),),
            onTap: (){
              Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop,child: CameraScanScreen(scanType: "nutrition",)));
            },
          ),
        ],
      )
    );
  }
}
