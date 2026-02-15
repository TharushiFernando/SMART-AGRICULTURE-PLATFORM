import 'package:cocosmartapp/provider/auth_provider/auth_provider.dart';
import 'package:cocosmartapp/provider/location_provider/location_provider.dart';
import 'package:cocosmartapp/screens/authentication_screen/login_screen/login_screen.dart';
import 'package:cocosmartapp/screens/dashboard_screen/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadState();
  }

  Future<void> loadState() async{
    bool? isLocationgranted = await Provider.of<LocationProvider>(context,listen: false).checkLocationPermission();
    if(!isLocationgranted){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text("Location permission is required to use this app!"))
      );
    }
    await Provider.of<AuthProvider>(context,listen: false).checkUserLoggedIn().then((status){
      if(status??false){
        Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft, child: DashboardScreen()));
      }else{
        Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft, child: LoginScreen()));
      }
    }).catchError((onError){
      Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft, child: LoginScreen()));
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Shimmer.fromColors(
              baseColor: Color.fromRGBO(52, 100, 52,1),
              highlightColor: Colors.white30,
              child: Image.asset(
                'assets/images/logo.png',
                width: 150,
                height: 150,
              ),
            ),
            SizedBox(height: 10),
            Text("COCO Smart", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700)),
            Text("Smarter Health, Predictable Yields", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          ],
        ),
      )
    );
  }
}
