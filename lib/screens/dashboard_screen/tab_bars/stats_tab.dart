import 'package:cocosmartapp/provider/estate_provider/land_provider.dart';
import 'package:cocosmartapp/provider/weather_provider/weather_provider.dart';
import 'package:cocosmartapp/screens/dashboard_screen/tab_bars/widgets/scan_methods_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../color_resources/color_resources.dart';

class StatsTab extends StatefulWidget {
  const StatsTab({super.key});

  @override
  State<StatsTab> createState() => _StatsTabState();
}

class _StatsTabState extends State<StatsTab> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback){
      getData();
    });
  }

  void getData() async {
    await Provider.of<LandProvider>(context,listen: false).getLands().then((onValue) async {
      LandProvider landProvider = Provider.of<LandProvider>(context,listen: false);
      await Provider.of<WeatherProvider>(context,listen: false).getWeatherData(landProvider.lands!.first.lat, landProvider.lands!.first.lng);
      await Provider.of<WeatherProvider>(context,listen: false).getSoilMoistureData(landProvider.lands!.first.lat, landProvider.lands!.first.lng);
    }).catchError((onError){
      print(onError);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
      builder: (BuildContext context, WeatherProvider weather_provider, Widget? child) {
        return Column(
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width,
              padding: EdgeInsets.all(35),
              decoration: BoxDecoration(
                  color: ColorResources.COLOR_PRIMARY,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: ColorResources.BORDER_COLOR)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("88%",style: TextStyle(fontSize: 50,fontWeight: FontWeight.w700,color: Colors.white),),
                  SizedBox(height: 10,),
                  Text("Overall Health Score",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w700,color: Colors.white),),
                  Text("Your plants are doing great!",style: TextStyle(fontSize: 14,color: Colors.white),),
                ],
              ),
            ),
            SizedBox(height: 20,),
            GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                mainAxisSpacing: 10,
                crossAxisSpacing: 20,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20,horizontal: 15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.1),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          )
                        ]
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Weather",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: ColorResources.MAIN_TEXT_COLOR),),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.cloud,size: 30,),
                            SizedBox(width: 15,),
                            Flexible(child: Text("${weather_provider.area_temperature}°C",style: TextStyle(fontSize: 20,color: ColorResources.MAIN_TEXT_COLOR),)),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text("${weather_provider.area_humidity}",style: TextStyle(fontSize: 14,color: Colors.grey,fontWeight: FontWeight.w700),)),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text("${weather_provider.rain_percentage}",style: TextStyle(fontSize: 14,color: Colors.grey,fontWeight: FontWeight.w700),)),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20,horizontal: 15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.1),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          )
                        ]
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Soil Moisture",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: ColorResources.MAIN_TEXT_COLOR),),
                        SizedBox(height: 10,),
                        Icon(Icons.water_drop_outlined,size: 30,),
                        SizedBox(height: 10,),
                        Text("${weather_provider.soil_moisture}%",style: TextStyle(fontSize: 14,color: Colors.grey,fontWeight: FontWeight.w700),),
                      ],
                    ),
                  ),
                ]
            ),
            SizedBox(height: 35,),
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorResources.BUTTON_BACKGROUND_COLOR,
                      padding: EdgeInsets.symmetric(horizontal: 50,vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      )
                  ),
                  onPressed: (){
                    showModalBottomSheet(
                        backgroundColor:ColorResources.MAIN_BACKGROUND_COLOR,
                        context: context,
                        builder: (conext){
                          return ScanMethodsBottomSheet();
                        }
                    );
                  },
                  child: Text("Start New Inspection",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w700),)
              ),
            ),
            SizedBox(height: 5,),
            Text("Last Inspection: 12 Aug, 2023",style: TextStyle(fontSize: 14,color: Colors.grey),)
          ],
        );
      },
    );
  }
}
