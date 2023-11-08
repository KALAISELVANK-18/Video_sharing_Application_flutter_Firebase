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
    apiKey: 'AIzaSyC_7L6vpj9O2aliq4nQESmDlesw8jzBJhM',
    appId: '1:1047840984022:web:85184bcf5463b321e2b277',
    messagingSenderId: '1047840984022',
    projectId: 'postit-dfc2c',
    authDomain: 'postit-dfc2c.firebaseapp.com',
    storageBucket: 'postit-dfc2c.appspot.com',
    measurementId: 'G-M7NYVH3VW6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBGC0AKm__R7-KF0N5ZslLDaudEVz7bjjQ',
    appId: '1:1047840984022:android:f60fbb380598024de2b277',
    messagingSenderId: '1047840984022',
    projectId: 'postit-dfc2c',
    storageBucket: 'postit-dfc2c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDwUK5yIIauuq-QA0bSl09LynmNq9Ziczc',
    appId: '1:1047840984022:ios:d44ba6256f8c8550e2b277',
    messagingSenderId: '1047840984022',
    projectId: 'postit-dfc2c',
    storageBucket: 'postit-dfc2c.appspot.com',
    iosClientId: '1047840984022-kutihlibv2hfkb98lhe8tcehsio1snm9.apps.googleusercontent.com',
    iosBundleId: 'com.example.postpro',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDwUK5yIIauuq-QA0bSl09LynmNq9Ziczc',
    appId: '1:1047840984022:ios:d44ba6256f8c8550e2b277',
    messagingSenderId: '1047840984022',
    projectId: 'postit-dfc2c',
    storageBucket: 'postit-dfc2c.appspot.com',
    iosClientId: '1047840984022-kutihlibv2hfkb98lhe8tcehsio1snm9.apps.googleusercontent.com',
    iosBundleId: 'com.example.postpro',
  );
}
