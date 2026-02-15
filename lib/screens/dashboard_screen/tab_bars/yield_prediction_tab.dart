import 'package:cocosmartapp/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../color_resources/color_resources.dart';

class YieldPredictionTab extends StatelessWidget {
  const YieldPredictionTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Center(child: Text("Yield Forecast",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: ColorResources.MAIN_TEXT_COLOR),)),
        SizedBox(height: 10,),
        GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            padding: EdgeInsets.symmetric(horizontal: 20),
            children: [
              Container(
                decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              padding: EdgeInsets.all(14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Estimated Nuts:",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700,color: ColorResources.MAIN_TEXT_COLOR),),
                  SizedBox(height: 5,),
                  Text("1250",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w800,color: ColorResources.MAIN_TEXT_COLOR),),
                  SizedBox(height: 5,),
                  Text("Per Month",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.grey),),
                ],
              ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                padding: EdgeInsets.all(14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Unit Price:",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700,color: ColorResources.MAIN_TEXT_COLOR),),
                    SizedBox(height: 5,),
                    Text("Rs.160.00",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w800,color: ColorResources.MAIN_TEXT_COLOR),),
                    SizedBox(height: 5,),
                    Text("Per Nut",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.grey),),
                  ],
                ),
              ),
            ]
        ),
        SizedBox(height: 10,),
        Divider(color: ColorResources.BORDER_COLOR,thickness: 5,radius: BorderRadius.circular(5),),
        SizedBox(height: 10,),
        Text("Refine Prediction",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: ColorResources.MAIN_TEXT_COLOR),),
        CustomTextField(
          isShowSuffixIcon: true,
          suffixIcon: Icon(Icons.thermostat,color: ColorResources.COLOR_PRIMARY,),
          isShowBorder: true,
          fillColor: Colors.transparent,
          hintText: "Soil PH Level",
        ),
        SizedBox(height: 5,),
        CustomTextField(
          isShowSuffixIcon: true,
          suffixIcon: Icon(Icons.thermostat,color: ColorResources.COLOR_PRIMARY,),
          isShowBorder: true,
          fillColor: Colors.transparent,
          hintText: "Soil Nitrogen Content",
        ),
        SizedBox(height: 5,),
        CustomTextField(
          isShowSuffixIcon: true,
          suffixIcon: Icon(Icons.thermostat,color: ColorResources.COLOR_PRIMARY,),
          isShowBorder: true,
          fillColor: Colors.transparent,
          hintText: "Soil Phosphorus Content",
        ),
        SizedBox(height: 5,),
        CustomTextField(
          isShowSuffixIcon: true,
          suffixIcon: Icon(Icons.thermostat,color: ColorResources.COLOR_PRIMARY,),
          isShowBorder: true,
          fillColor: Colors.transparent,
          hintText: "Soil Potassium Content",
        ),
        SizedBox(height: 5,),
        CustomTextField(
          isShowSuffixIcon: true,
          suffixIcon: Icon(Icons.thermostat,color: ColorResources.COLOR_PRIMARY,),
          isShowBorder: true,
          fillColor: Colors.transparent,
          hintText: "Palm Age",
        ),
        SizedBox(height: 40,),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: ColorResources.COLOR_PRIMARY,
                padding: EdgeInsets.symmetric(horizontal: 50,vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                )
            ),
            onPressed: (){

            },
            child: Text("Calculate Yield",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w700),)
        ),
      ],
    );
  }
}