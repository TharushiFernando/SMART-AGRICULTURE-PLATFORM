import 'package:cocosmartapp/provider/yield_prediction_provider/yield_prediction_provider.dart';
import 'package:cocosmartapp/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../../color_resources/color_resources.dart';

class YieldPredictionTab extends StatefulWidget {
  YieldPredictionTab({Key? key}) : super(key: key);

  @override
  State<YieldPredictionTab> createState() => _YieldPredictionTabState();
}

class _YieldPredictionTabState extends State<YieldPredictionTab> {
  TextEditingController soilPhController = TextEditingController();

  TextEditingController nitrogenController = TextEditingController();

  TextEditingController phosphorusController = TextEditingController();

  TextEditingController potassiumController = TextEditingController();

  TextEditingController treePalmAgeController = TextEditingController();

  TextEditingController fertilizerAppliedController = TextEditingController();

  FocusNode soilPhFocusNode = FocusNode();

  FocusNode nitrogenFocusNode = FocusNode();

  FocusNode phosphorusFocusNode = FocusNode();

  FocusNode potassiumFocusNode = FocusNode();

  FocusNode treePalmAgeFocusNode = FocusNode();

  FocusNode fertilizerAppliedFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback){
      Provider.of<YieldPredictionProvider>(context,listen: false).getUnitPrice();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<YieldPredictionProvider>(
      builder: (BuildContext context, YieldPredictionProvider yireld_provider, Widget? child) {
        return  ListView(
          shrinkWrap: true,
          children: [
            SizedBox(height: 20,),
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
                        SizedBox(height: 10,),
                        (yireld_provider.isPredictingYield??false)?LoadingAnimationWidget.fourRotatingDots(color: ColorResources.MAIN_TEXT_COLOR, size: 20):Text("${yireld_provider.predictedYield}",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w800,color: ColorResources.MAIN_TEXT_COLOR),),
                        SizedBox(height: 10,),
                        Text("x1000 Per Month",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.grey),),
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
                        SizedBox(height: 10,),
                        Text("Rs.${yireld_provider.unitPrice}",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w800,color: ColorResources.MAIN_TEXT_COLOR),),
                        SizedBox(height: 10,),
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
            SizedBox(height: 5,),
            TextField(
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              focusNode: soilPhFocusNode,
              controller: soilPhController,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorResources.BUTTON_BACKGROUND_COLOR,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: ColorResources.MAIN_TEXT_COLOR,
                      width: 2
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                hintText: 'Soil PH Level',
                hintStyle: TextStyle(fontSize: 14,color: Colors.grey),
                prefixIcon: Icon(CupertinoIcons.circle_grid_hex),
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              focusNode: nitrogenFocusNode,
              controller: nitrogenController,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorResources.BUTTON_BACKGROUND_COLOR,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: ColorResources.MAIN_TEXT_COLOR,
                      width: 2
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                hintText: 'Nitrogen Level',
                hintStyle: TextStyle(fontSize: 14,color: Colors.grey),
                prefixIcon: Icon(CupertinoIcons.lab_flask_solid),
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              focusNode: phosphorusFocusNode,
              controller: phosphorusController,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorResources.BUTTON_BACKGROUND_COLOR,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: ColorResources.MAIN_TEXT_COLOR,
                      width: 2
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                hintText: 'Phosphorus Level',
                hintStyle: TextStyle(fontSize: 14,color: Colors.grey),
                prefixIcon: Icon(CupertinoIcons.lab_flask_solid),
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              focusNode: potassiumFocusNode,
              controller: potassiumController,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorResources.BUTTON_BACKGROUND_COLOR,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: ColorResources.MAIN_TEXT_COLOR,
                      width: 2
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                hintText: 'Potassium Level',
                hintStyle: TextStyle(fontSize: 14,color: Colors.grey),
                prefixIcon: Icon(CupertinoIcons.lab_flask_solid),
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              focusNode: treePalmAgeFocusNode,
              controller: treePalmAgeController,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorResources.BUTTON_BACKGROUND_COLOR,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: ColorResources.MAIN_TEXT_COLOR,
                      width: 2
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                hintText: 'Tree Palm Age',
                hintStyle: TextStyle(fontSize: 14,color: Colors.grey),
                prefixIcon: Icon(CupertinoIcons.tree),
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              focusNode: fertilizerAppliedFocusNode,
              controller: fertilizerAppliedController,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorResources.BUTTON_BACKGROUND_COLOR,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: ColorResources.MAIN_TEXT_COLOR,
                      width: 2
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                hintText: 'Fertilizer Applied (kg)',
                hintStyle: TextStyle(fontSize: 14,color: Colors.grey),
                prefixIcon: Icon(CupertinoIcons.archivebox),
              ),
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
                  if(soilPhController.text.isEmpty||nitrogenController.text.isEmpty||phosphorusController.text.isEmpty||potassiumController.text.isEmpty||treePalmAgeController.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill all the fields"),backgroundColor: Colors.red,));
                    return;
                  }

                  final data = {
                    "soil_ph": double.parse(soilPhController.text),
                    "nitrogen_N": double.parse(nitrogenController.text),
                    "phosphorus_P": double.parse(phosphorusController.text),
                    "potassium_K": double.parse(potassiumController.text),
                    "palm_age_years": double.parse(treePalmAgeController.text),
                    "rainfall_mm_month": 60,
                    "temperature_c_month": 32.5,
                    "fertilizer_applied_kg": double.parse(fertilizerAppliedController.text),
                    "month": DateTime.now().month
                  };
                  yireld_provider.getYieldPrediction(data);

                },
                child: (yireld_provider.isPredictingYield??false)?LoadingAnimationWidget.fourRotatingDots(color: Colors.white, size: 20):Text("Calculate Yield",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w700),)
            ),
          ],
        );
      },
    );
  }
}