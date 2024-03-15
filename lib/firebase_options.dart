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
    apiKey: 'AIzaSyCopT6eAdaWZ1zMtJBxtjUzr97q15wVIXg',
    appId: '1:178769548108:web:9a992123f2eab0dd2a35e9',
    messagingSenderId: '178769548108',
    projectId: 'chatapp-15d3d',
    authDomain: 'chatapp-15d3d.firebaseapp.com',
    storageBucket: 'chatapp-15d3d.appspot.com',
    measurementId: 'G-9WEHVXR5K3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD7eSeqA6aPOi5YSG_OmJt2uR_lCjFjWfI',
    appId: '1:178769548108:android:a2bc6e9efca182ad2a35e9',
    messagingSenderId: '178769548108',
    projectId: 'chatapp-15d3d',
    storageBucket: 'chatapp-15d3d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyApTl2Dg5quL0ATN6MOYj9Zr3tBadvzSvA',
    appId: '1:178769548108:ios:24d731d1a6eb00152a35e9',
    messagingSenderId: '178769548108',
    projectId: 'chatapp-15d3d',
    storageBucket: 'chatapp-15d3d.appspot.com',
    iosBundleId: 'com.example.chatapp',
  );
}