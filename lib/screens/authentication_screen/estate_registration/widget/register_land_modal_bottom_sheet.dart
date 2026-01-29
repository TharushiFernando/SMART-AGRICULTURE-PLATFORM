import 'package:cocosmartapp/provider/estate_provider/land_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../../color_resources/color_resources.dart';
import '../../../dashboard_screen/dashboard_screen.dart';

class RegisterLandModalBottomSheet extends StatefulWidget {
  final LatLng? landPosition;
  const RegisterLandModalBottomSheet({super.key,required this.landPosition});

  @override
  State<RegisterLandModalBottomSheet> createState() => _RegisterLandModalBottomSheetState();
}

class _RegisterLandModalBottomSheetState extends State<RegisterLandModalBottomSheet> {
  TextEditingController landNameController = TextEditingController();
  TextEditingController landPalmAgeYearsController = TextEditingController();
  TextEditingController landSizeController = TextEditingController();

  FocusNode landNameFocusNode = FocusNode();
  FocusNode landPalmAgeYearsFocusNode = FocusNode();
  FocusNode landSizeFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Consumer<LandProvider>(
      builder: (BuildContext context, LandProvider land_provider, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios_new_rounded,color: Colors.white,)
            ),
            backgroundColor: ColorResources.MAIN_TEXT_COLOR,
            elevation: 0,
            centerTitle: true,
            title: Text("Register Land",style: TextStyle(fontWeight: FontWeight.w700,color: Colors.white),),
          ),
          body: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Container(
              color: ColorResources.MAIN_BACKGROUND_COLOR,
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Land Name",style: TextStyle(color: ColorResources.MAIN_TEXT_COLOR,fontSize: 14,fontWeight: FontWeight.w600),),
                  SizedBox(height: 5,),
                  TextField(
                    textInputAction: TextInputAction.next,
                    focusNode: landNameFocusNode,
                    controller: landNameController,
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
                      hintText: 'Land Name',
                      hintStyle: TextStyle(fontSize: 14,color: Colors.grey),
                      prefixIcon: Icon(CupertinoIcons.rectangle),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text("Enter the Palm Age years",style: TextStyle(color: ColorResources.MAIN_TEXT_COLOR,fontSize: 14,fontWeight: FontWeight.w600),),
                  SizedBox(height: 5,),
                  TextField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    focusNode: landPalmAgeYearsFocusNode,
                    controller: landPalmAgeYearsController,
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
                      hintText: 'Palm Age Years',
                      hintStyle: TextStyle(fontSize: 14,color: Colors.grey),
                      prefixIcon: Icon(CupertinoIcons.tree),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text("Land Size",style: TextStyle(color: ColorResources.MAIN_TEXT_COLOR,fontSize: 14,fontWeight: FontWeight.w600),),
                  SizedBox(height: 5,),
                  TextField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    focusNode: landSizeFocusNode,
                    controller: landSizeController,
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
                      hintText: 'Land Size (acre)',
                      hintStyle: TextStyle(fontSize: 14,color: Colors.grey),
                      prefixIcon: Icon(CupertinoIcons.resize),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0,vertical: 20),
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorResources.BUTTON_BACKGROUND_COLOR,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () async {
                          String landName = landNameController.text.trim();
                          String landPalmAgeYears = landPalmAgeYearsController.text.trim();
                          String landSize = landSizeController.text.trim();
                          double lat = widget.landPosition!.latitude;
                          double lng = widget.landPosition!.longitude;
            
                          if(landName.isEmpty){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.red,
                                content: Text("Please enter the land name")
                            ));
                            Navigator.pop(context);
                            return;
                          }
                          if(landPalmAgeYears.isEmpty){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.red,
                                content: Text("Please enter the palm age in years!")
                            ));
                            Navigator.pop(context);
                            return;
                          }
                          if(landSize.isEmpty){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.red,
                                content: Text("Please enter the land size in acres!")
                            ));
                            Navigator.pop(context);
                            return;
                          }
                          land_provider.registerLand(landName,landSize,landPalmAgeYears,lat, lng).then((onValue){
                            Navigator.pushAndRemoveUntil(context, PageTransition(type: PageTransitionType.rightToLeft,child: DashboardScreen()), (route) => false);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.green,
                                content: Text("Registration successfully!")
                            ));
                          }).catchError((onError){
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.red,
                                content: Text("${onError.toString()}")
                            ));
                          });
                        },
                        child: land_provider.isLoading?LoadingAnimationWidget.fourRotatingDots(color: Colors.white, size: 35):Text("Finalize Land Registration",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white),),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
