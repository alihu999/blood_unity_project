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
        return macos;
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
    apiKey: 'AIzaSyACzcJ2YwhZA7ocM42cJOwpAloAWUbpQO4',
    appId: '1:406949483716:web:5afd0b0f8e665945842591',
    messagingSenderId: '406949483716',
    projectId: 'blood-unity-cbba1',
    authDomain: 'blood-unity-cbba1.firebaseapp.com',
    storageBucket: 'blood-unity-cbba1.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBfg6qLrTyWKZZR-qHAKmkWRDDO8yjs-ZM',
    appId: '1:406949483716:android:a4a0a63c29592899842591',
    messagingSenderId: '406949483716',
    projectId: 'blood-unity-cbba1',
    storageBucket: 'blood-unity-cbba1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCoSNC-SvWKVi2NlKbWJKSZjcWrqtCIKLk',
    appId: '1:406949483716:ios:75ca7d1ce00b08ce842591',
    messagingSenderId: '406949483716',
    projectId: 'blood-unity-cbba1',
    storageBucket: 'blood-unity-cbba1.appspot.com',
    androidClientId: '406949483716-cne3t8q4qk7q4s2ju3usjqicht632phn.apps.googleusercontent.com',
    iosClientId: '406949483716-rn7tuag7cc5pg05eu90qcgfri5qb0gnb.apps.googleusercontent.com',
    iosBundleId: 'com.example.bloodUnityWeb',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCoSNC-SvWKVi2NlKbWJKSZjcWrqtCIKLk',
    appId: '1:406949483716:ios:a3abec3fc878877b842591',
    messagingSenderId: '406949483716',
    projectId: 'blood-unity-cbba1',
    storageBucket: 'blood-unity-cbba1.appspot.com',
    androidClientId: '406949483716-cne3t8q4qk7q4s2ju3usjqicht632phn.apps.googleusercontent.com',
    iosClientId: '406949483716-1rbhvmp9jjmd32ak5plpsvlivbipesmu.apps.googleusercontent.com',
    iosBundleId: 'com.example.bloodUnityWeb.RunnerTests',
  );
}
