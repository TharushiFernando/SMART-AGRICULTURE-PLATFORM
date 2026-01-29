import 'package:cocosmartapp/color_resources/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../../provider/irigation_provider/irigation_recommender_provider.dart';

class IrigationTab extends StatefulWidget {
  const IrigationTab({super.key});

  @override
  State<IrigationTab> createState() => _IrigationTabState();
}

class _IrigationTabState extends State<IrigationTab> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  void loadData() async {
    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      await Provider.of<IrrigationRecommenderProvider>(context,listen: false).getIrrigationRecommendation(context);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<IrrigationRecommenderProvider>(
      builder: (BuildContext context, IrrigationRecommenderProvider irigation_provider, Widget? child) {
        return  ListView(
          shrinkWrap: true,
          children: [
            (irigation_provider.isIrrigationRecommended??false)?Column(
              children: [
                Center(child: Text("Next Recommended Watering",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: ColorResources.MAIN_TEXT_COLOR),)),
                SizedBox(height: 20,),
                Center(child: Text(DateFormat('EEEE, MMM d').format(irigation_provider.nextIrrigationTimeRecommendation),style: TextStyle(fontSize: 30,fontWeight: FontWeight.w800,color: ColorResources.MAIN_TEXT_COLOR),)),
                SizedBox(height: 20,),
                Icon(Icons.water_drop,color: Colors.blueAccent,size: 80,),
                SizedBox(height: 10,),
                Center(child: Text("Recommended Amount",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: ColorResources.MAIN_TEXT_COLOR),)),
                SizedBox(height: 5,),
                Center(child: Text("${irigation_provider.waterAmountRecommendation} Litters",style: TextStyle(fontSize: 35,fontWeight: FontWeight.w800,color: ColorResources.MAIN_TEXT_COLOR),)),
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
                      irigation_provider.setReminderForNextIrrigation(irigation_provider.nextIrrigationTimeRecommendation).then((onValue){
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                backgroundColor: Colors.green,
                                content: Text("Reminder Set Successfully"))
                        );
                      });
                    },
                    child: Text("Set Reminder",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w700),)
                ),
              ],
            ):notRecomendedWidget(),
            SizedBox(height: 20,),
            (irigation_provider.isIrrigationRecommending??false)?LoadingAnimationWidget.fourRotatingDots(color: ColorResources.MAIN_TEXT_COLOR, size: 35):TextButton(
              onPressed: (){
                loadData();
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
      },
    );
  }

  Widget notRecomendedWidget(){
    return Column(
      children: [
        SizedBox(height: 20,),
        Center(child: Text("No Irrigation Needed",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: ColorResources.MAIN_TEXT_COLOR),)),
        SizedBox(height: 20,),
        Icon(Icons.water_drop,color: Colors.blueAccent,size: 80,),
        SizedBox(height: 10,),
        Center(child: Text("Your crops are well hydrated and do not require irrigation at this time.",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: ColorResources.MAIN_TEXT_COLOR),textAlign: TextAlign.center,)),
        SizedBox(height: 40,),
      ],
    );
  }
}
