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
    apiKey: 'AIzaSyDjBJi_TaQOPpR52QWUpdUcuP5bEx3XD_w',
    appId: '1:197266515424:web:65a67472e168e710dc7785',
    messagingSenderId: '197266515424',
    projectId: 'tms-partner-app',
    authDomain: 'tms-partner-app.firebaseapp.com',
    storageBucket: 'tms-partner-app.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBYEIedJyXL4m8AHqHdXZfYdiMoIrUKx0M',
    appId: '1:197266515424:android:cc7e8511d26e0260dc7785',
    messagingSenderId: '197266515424',
    projectId: 'tms-partner-app',
    storageBucket: 'tms-partner-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCjAL_keDABM4ptCOSi7QIHBz9wfzTtFlQ',
    appId: '1:197266515424:ios:ba39cdf0f3f51fd2dc7785',
    messagingSenderId: '197266515424',
    projectId: 'tms-partner-app',
    storageBucket: 'tms-partner-app.appspot.com',
    iosClientId: '197266515424-ar4c65h577t79bqs14liviljrac2rng9.apps.googleusercontent.com',
    iosBundleId: 'com.supra.tmsPartnerApp',
  );
}