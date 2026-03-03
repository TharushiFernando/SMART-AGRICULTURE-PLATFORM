import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationProvider extends ChangeNotifier{

  double latitude = 0.0;
  double longitude = 0.0;

  CameraPosition? initialCameraPosition;

  Future<void> setInitialCameraPosition() async {
    getCurrentLocation().then((onValue){
      initialCameraPosition = CameraPosition(
        target: LatLng(latitude, longitude),
        zoom: 18,
      );
      notifyListeners();
    });
  }

  void setLocation(double lat, double lon){
    latitude = lat;
    longitude = lon;
    notifyListeners();
  }

  Future<bool> checkLocationPermission() async {
    bool? isLocationService = await Geolocator.isLocationServiceEnabled();
    if (!isLocationService) {
      return false;
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
      return true;
    }
    else if(permission == LocationPermission.deniedForever){
      return false;
    }
    else{
      return true;
    }
  }

  Future <void> getCurrentLocation() async {
    try{
      Position position = await Geolocator.getCurrentPosition(locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      ));
      latitude = position.latitude;
      longitude = position.longitude;
      notifyListeners();
    }catch(ex){
      print('Error: $ex');
    }
  }

}