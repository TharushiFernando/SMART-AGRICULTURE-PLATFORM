import 'dart:async';

import 'package:cocosmartapp/color_resources/color_resources.dart';
import 'package:cocosmartapp/provider/estate_provider/land_provider.dart';
import 'package:cocosmartapp/provider/location_provider/location_provider.dart';
import 'package:cocosmartapp/screens/authentication_screen/estate_registration/widget/register_land_modal_bottom_sheet.dart';
import 'package:cocosmartapp/screens/dashboard_screen/dashboard_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class EstateLocationScreen extends StatefulWidget {
  const EstateLocationScreen({super.key});

  @override
  State<EstateLocationScreen> createState() => _EstateLocationScreenState();
}

class _EstateLocationScreenState extends State<EstateLocationScreen> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  LatLng? landPosition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback){
      Provider.of<LocationProvider>(context,listen: false).setInitialCameraPosition();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<LocationProvider,LandProvider>(
      builder: (BuildContext context, LocationProvider location_provider,LandProvider land_provider, Widget? child) {
        return Scaffold(
          backgroundColor: ColorResources.MAIN_BACKGROUND_COLOR,
          body: location_provider.initialCameraPosition != null?
          Stack(
            children: [
              GoogleMap(
                initialCameraPosition: location_provider.initialCameraPosition!,
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                onCameraMove: (cameraPosition){
                  setState(() {
                    landPosition = cameraPosition.target;
                  });
                },
              ),
              SafeArea(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.75),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0,2)
                        )
                      ]
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 8,vertical: 10),
                    child: Text("🌴Drag to select your estate location",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700,color: ColorResources.MAIN_TEXT_COLOR),),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Icon(Icons.location_on_rounded,color: Colors.red,size: 50,),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
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
                          Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop,child: RegisterLandModalBottomSheet(landPosition: landPosition)));
                        },
                        child: Text("Confirm Location",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white),),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ):
          Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Future<void> goToPosition(LatLng position) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: position,
        zoom: 14.4746,
      ),
    ));
  }
}
