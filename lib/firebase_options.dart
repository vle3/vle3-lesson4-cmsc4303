// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDf8O3oBoBxAWsAJWnweCJb7b8LvrSxt8o',
    appId: '1:268854806625:web:e4cbdc9542ce892195c220',
    messagingSenderId: '268854806625',
    projectId: 'vle3-cmsc4303-f22-mobileapps',
    authDomain: 'vle3-cmsc4303-f22-mobileapps.firebaseapp.com',
    storageBucket: 'vle3-cmsc4303-f22-mobileapps.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDG5poew4QmjjygUcicQLubLWrHroYGvBA',
    appId: '1:268854806625:android:9162013e6061a91595c220',
    messagingSenderId: '268854806625',
    projectId: 'vle3-cmsc4303-f22-mobileapps',
    storageBucket: 'vle3-cmsc4303-f22-mobileapps.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDAE5HsSY2ooMLHMXCrPQuyjjEkGu5eQHQ',
    appId: '1:268854806625:ios:935a0c5a7166d54695c220',
    messagingSenderId: '268854806625',
    projectId: 'vle3-cmsc4303-f22-mobileapps',
    storageBucket: 'vle3-cmsc4303-f22-mobileapps.appspot.com',
    iosClientId: '268854806625-2n3r7l4221gb0or5rq69jvelt3ei02rk.apps.googleusercontent.com',
    iosBundleId: 'edu.uco.vle3.cmsc4303.lesson4',
  );
}