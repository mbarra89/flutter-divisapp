// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyBwiD69fO3WMyicMSdcrNMgt9S-y8Kimeo',
    appId: '1:414769625903:web:5d44a7035ab166a86f3fda',
    messagingSenderId: '414769625903',
    projectId: 'divisapp-c8852',
    authDomain: 'divisapp-c8852.firebaseapp.com',
    storageBucket: 'divisapp-c8852.firebasestorage.app',
    measurementId: 'G-CXGQ1MBN8Z',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyASpmYfiF_wCtuhJhzRnnFLsKY9ARurlSU',
    appId: '1:414769625903:android:7b96fda7e4150af16f3fda',
    messagingSenderId: '414769625903',
    projectId: 'divisapp-c8852',
    storageBucket: 'divisapp-c8852.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBcce53ACUNGIFetwne-i5AUHkuMzqccBk',
    appId: '1:414769625903:ios:eff2fdce9c22ffd06f3fda',
    messagingSenderId: '414769625903',
    projectId: 'divisapp-c8852',
    storageBucket: 'divisapp-c8852.firebasestorage.app',
    iosBundleId: 'com.example.divisapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBcce53ACUNGIFetwne-i5AUHkuMzqccBk',
    appId: '1:414769625903:ios:eff2fdce9c22ffd06f3fda',
    messagingSenderId: '414769625903',
    projectId: 'divisapp-c8852',
    storageBucket: 'divisapp-c8852.firebasestorage.app',
    iosBundleId: 'com.example.divisapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBwiD69fO3WMyicMSdcrNMgt9S-y8Kimeo',
    appId: '1:414769625903:web:efede2cf24f13daf6f3fda',
    messagingSenderId: '414769625903',
    projectId: 'divisapp-c8852',
    authDomain: 'divisapp-c8852.firebaseapp.com',
    storageBucket: 'divisapp-c8852.firebasestorage.app',
    measurementId: 'G-VXRYYKH2ZK',
  );
}
