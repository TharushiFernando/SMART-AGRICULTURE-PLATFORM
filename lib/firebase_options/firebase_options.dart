import 'dart:io';

import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions{

  static FirebaseOptions get currentPlatform {
    switch(Platform.operatingSystem){
      case 'android':
        return android;
      case 'ios':
        return ios;
      default:
        throw UnsupportedError('DefaultFirebaseOptions are not supported for this platform.');
    }
  }
}

const FirebaseOptions android = FirebaseOptions(
  apiKey: 'AIzaSyCN3zIwa-fSL2jWrgPgk-8cr7J7GEeqBIw',
  appId: '1:507776540765:android:5ee436c60173db775c6db4',
  messagingSenderId: '507776540765',
  projectId: 'access-control-system-28125',
  storageBucket: 'access-control-system-28125.appspot.com',
);

const FirebaseOptions ios = FirebaseOptions(
  apiKey: 'AIzaSyB0SeXKaL2OnvTqn7gf-HKpPuaG8CjpFQE',
  appId: '1:1234567890:ios:abcdef123456',
  messagingSenderId: '507776540765',
  projectId: 'access-control-system-28125',
  storageBucket: 'access-control-system-28125.appspot.com',
  iosBundleId: 'com.invader.cocosmart.cocosmartapp',
  iosClientId: '1507776540765-cpqs809m4dutv0tf7crip9q5eir47oml.apps.googleusercontent.com',
);