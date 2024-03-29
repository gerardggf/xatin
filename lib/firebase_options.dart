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
    apiKey: 'AIzaSyBwYMtnBR-rgh16zBK7X2jx5YQIWhwysBg',
    appId: '1:616303858829:web:e610d5928ded91962cfec4',
    messagingSenderId: '616303858829',
    projectId: 'xatin-fbb71',
    authDomain: 'xatin-fbb71.firebaseapp.com',
    storageBucket: 'xatin-fbb71.appspot.com',
    measurementId: 'G-92RN0VDBR2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCxxXMiUdrEFU7u7ywNWKQ0kCQ8rR02LW4',
    appId: '1:616303858829:android:ca2ad38ec08a4e272cfec4',
    messagingSenderId: '616303858829',
    projectId: 'xatin-fbb71',
    storageBucket: 'xatin-fbb71.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCaAG_i7N6GM0IKGNfl4hECTlrvndK8PI8',
    appId: '1:616303858829:ios:98f314bb243e19c32cfec4',
    messagingSenderId: '616303858829',
    projectId: 'xatin-fbb71',
    storageBucket: 'xatin-fbb71.appspot.com',
    iosBundleId: 'com.sanfaina.xatin',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCaAG_i7N6GM0IKGNfl4hECTlrvndK8PI8',
    appId: '1:616303858829:ios:98f314bb243e19c32cfec4',
    messagingSenderId: '616303858829',
    projectId: 'xatin-fbb71',
    storageBucket: 'xatin-fbb71.appspot.com',
    iosBundleId: 'com.sanfaina.xatin',
  );
}
