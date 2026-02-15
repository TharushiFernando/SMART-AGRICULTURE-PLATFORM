import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocosmartapp/models/user_model/user_models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier{
  UserModels? userModels;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  bool isLoading = false;

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try{
      isLoading = true;
      notifyListeners();

      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      await getUserData(userCredential.user);

      isLoading = false;
      notifyListeners();
    }on FirebaseAuthException catch(ex){
      isLoading = false;
      notifyListeners();
      print(ex);
      throw Exception([ex.message]);
    }

  }

  Future<void> signUpWithEmailAndPassword(String email,String name,String phone, String password) async {
    try{
      isLoading = true;
      notifyListeners();

      UserCredential credential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = credential.user;

      if(user!=null){
        try{
          await firebaseFirestore.collection('users').doc(user.uid).set({
            'uid': user.uid,
            'email': email,
            'username': name,
            'phoneNumber': phone,
          });

          await getUserData(user);

          isLoading = false;
          notifyListeners();
        }on FirebaseException catch(ex){
          isLoading = false;
          notifyListeners();
          throw Exception([ex.message]);
        }
      }
    }on FirebaseAuthException catch(ex){
      isLoading = false;
      notifyListeners();
      throw Exception([ex.message]);
    }
  }

  Future<bool?> checkUserLoggedIn() async {
    User? user = firebaseAuth.currentUser;
    if(user!=null){
      await getUserData(user);
      return true;
    }else{
      return false;
    }
  }

  Future<void> getUserData(User? firebaseuser) async {
    User? user = firebaseuser;
    if(user!=null){
      try{
        DocumentSnapshot userDoc = await firebaseFirestore.collection('users').doc(user.uid).get();
        userModels = UserModels.fromJson(userDoc.data() as Map<String, dynamic>);
        notifyListeners();
        await saveFirebaseToken(user.uid);
      }
      on FirebaseException catch(ex){
        print(ex);
        throw Exception([ex.message]);
      }
    }
  }

  Future<void> saveFirebaseToken(String uid) async {
    try{
      NotificationSettings settings =
      await FirebaseMessaging.instance.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
      String? apnsToken = await FirebaseMessaging.instance.getAPNSToken();
      if (apnsToken == null) {
        print('APNS token not ready');
        return;
      }
      String? firebaseToken = await firebaseMessaging.getToken(
        vapidKey: apnsToken,
      );
      await firebaseFirestore.collection('users').doc(uid).update({
        'firebaseToken': firebaseToken,
      });
    }catch(ex){
      print(ex);
    }
  }

  Future <void> signOut() async {
    try{
      await firebaseAuth.signOut();
      userModels = null;
      notifyListeners();
    }on FirebaseAuthException catch(ex){
      print(ex);
      throw Exception([ex.message]);
    }
  }

}