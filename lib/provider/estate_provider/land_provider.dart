import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocosmartapp/models/land_model/land_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LandProvider extends ChangeNotifier{

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  bool isLoading = false;
  List<LandModel>? lands = [];

  Future<void> registerLand(String landName, String landSize, String palmAgeYears,double lat,double lng) async {
    try{
      User? user = firebaseAuth.currentUser;
      if(user!=null){
        isLoading = true;
        notifyListeners();
        await firebaseFirestore.collection('users').doc(user.uid).collection("lands").add({
          'landName': landName,
          'landSize': landSize,
          'palmAgeYears': palmAgeYears,
          'lat': lat,
          'lng': lng,
        });
        isLoading = false;
        notifyListeners();
      }else{
        isLoading = false;
        notifyListeners();
        throw Exception(['User not authenticated']);
      }
    }on FirebaseException catch(ex){
      isLoading = false;
      notifyListeners();
      print(ex);
      throw Exception([ex.message]);
    }
  }

  Future<void> getLands() async {
    try{
      User? user = firebaseAuth.currentUser;
      if(user!=null){
        isLoading = true;
        notifyListeners();
        QuerySnapshot snapshot = await firebaseFirestore.collection('users').doc(user.uid).collection("lands").get(GetOptions(source: Source.serverAndCache));
        for(var doc in snapshot.docs){
          final jsonData = {
            'id': doc.id,
            'name': doc['landName'],
            'size': doc['landSize'],
            'palmAgeYears': doc['palmAgeYears'],
            'lat': doc['lat'],
            'lng': doc['lng'],
          };
          lands?.add(LandModel.fromJson(jsonData));
        }
        isLoading = false;
        notifyListeners();
      }else{
        isLoading = false;
        notifyListeners();
        throw Exception(['User not authenticated']);
      }
    }on FirebaseException catch(ex){
      isLoading = false;
      notifyListeners();
      print(ex);
      throw Exception([ex.message]);
    }
  }

}