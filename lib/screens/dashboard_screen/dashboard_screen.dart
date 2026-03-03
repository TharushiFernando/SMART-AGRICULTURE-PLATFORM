import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cocosmartapp/provider/auth_provider/auth_provider.dart';
import 'package:cocosmartapp/provider/estate_provider/land_provider.dart';
import 'package:cocosmartapp/screens/dashboard_screen/tab_bars/irigation_tab.dart';
import 'package:cocosmartapp/screens/dashboard_screen/tab_bars/stats_tab.dart';
import 'package:cocosmartapp/screens/dashboard_screen/tab_bars/yield_prediction_tab.dart';
import 'package:cocosmartapp/screens/notification_screen/notification_screen.dart';
import 'package:cocosmartapp/screens/splash_screen/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../color_resources/color_resources.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with SingleTickerProviderStateMixin{
  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener((){
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (BuildContext context, AuthProvider authProvider, Widget? child) {
        return Scaffold(
            backgroundColor: ColorResources.MAIN_BACKGROUND_COLOR,
            appBar: AppBar(
              surfaceTintColor: Colors.white,
              backgroundColor: Colors.white,
              centerTitle: false,
              title: Text('Hello, ${authProvider.userModels?.username}!',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800,color: ColorResources.MAIN_TEXT_COLOR),),
              actions: [
                InkWell(
                    onTap: (){
                      Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft,child: NotificationScreen()));
                    },
                    child: Icon(Icons.notifications_none_rounded,color: ColorResources.MAIN_TEXT_COLOR,size: 30,)),
                SizedBox(width: 8,),
                CircularProfileAvatar("imageUrl",errorWidget: (context,string,object){
                  return GestureDetector(
                    onTap: (){
                      authProvider.signOut().then((onValue){
                        Navigator.pushAndRemoveUntil(context, PageTransition(type: PageTransitionType.rightToLeft,child: SplashScreen()), (route)=>false);
                      });
                    },
                      child: Icon(CupertinoIcons.person,color: ColorResources.MAIN_TEXT_COLOR,size: 30,));
                },
                  radius: 20,
                  backgroundColor: Colors.white,
                  placeHolder: (context,image){
                    return Shimmer(
                      gradient: RadialGradient(
                          colors: [
                            Colors.grey.shade300,
                            Colors.grey.shade100,
                            Colors.grey.shade300,
                          ]
                      ),
                      child: Container(
                        width: 30,
                        height: 30,
                      ),
                    );
                  },
                  animateFromOldImageOnUrlChange: true,
                  borderWidth: 1,
                  elevation: 0,
                  borderColor: ColorResources.BORDER_COLOR,
                  cacheImage: true,
                  showInitialTextAbovePicture: false,
                ),
                SizedBox(width: 10,),
              ],
            ),
            body: Container(
                padding: EdgeInsets.all(15),
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(child: Image.asset("assets/images/logo.png",fit: BoxFit.cover,width: 60,height: 60,)),
                    Text('COCO Smart',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700,color: ColorResources.MAIN_TEXT_COLOR,letterSpacing: 0),),
                    SizedBox(height: 15,),
                    TabBar(
                      controller: tabController,
                      indicatorColor: Colors.transparent,
                      dividerHeight: 0,
                      tabAlignment: TabAlignment.center,
                      labelColor: ColorResources.MAIN_TEXT_COLOR,
                      tabs: List.generate(3, (index) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 4,vertical: 3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: tabController.index == index
                                ? ColorResources.BUTTON_BACKGROUND_COLOR
                                : ColorResources.BORDER_COLOR,
                          ),
                          child: Row(
                            children: [
                              Icon(index ==0?Icons.search_rounded:index==1?Icons.water_drop_rounded:CupertinoIcons.chart_bar_alt_fill,
                                color: index == tabController.index?Colors.white:ColorResources.MAIN_TEXT_COLOR,),
                              SizedBox(width: 5,),
                              Text(index ==0?"Health":index==1?"Irigation":"Yield",style: TextStyle(color: index == tabController.index?Colors.white:ColorResources.MAIN_TEXT_COLOR,),)
                            ],
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: 15,),
                    Flexible(
                      child: TabBarView(
                          controller: tabController,
                          children: [
                            StatsTab(),
                            IrigationTab(),
                            YieldPredictionTab()
                          ]
                      ),
                    ),
                  ],
                )
            )
        );
      },
    );
  }
}
