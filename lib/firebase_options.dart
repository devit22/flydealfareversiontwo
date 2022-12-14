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
    apiKey: 'AIzaSyBGZu561QX3PDwvLSObc266hVs2naa1gO8',
    appId: '1:522987606252:web:cb936912a96395b73b95c9',
    messagingSenderId: '522987606252',
    projectId: 'newflydealfare',
    authDomain: 'newflydealfare.firebaseapp.com',
    storageBucket: 'newflydealfare.appspot.com',
    measurementId: 'G-LQZTX8VV0P',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyALXjEhQ5Nz9CIODao0C4gewpVMt_noy8c',
    appId: '1:522987606252:android:6d6d2cf94df1fe4b3b95c9',
    messagingSenderId: '522987606252',
    projectId: 'newflydealfare',
    storageBucket: 'newflydealfare.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAgJIqMzfrmqvP5kiy3GpvXKPkLmZQN5AM',
    appId: '1:522987606252:ios:673c0e23caf3cf283b95c9',
    messagingSenderId: '522987606252',
    projectId: 'newflydealfare',
    storageBucket: 'newflydealfare.appspot.com',
    androidClientId: '522987606252-368a1qnmm90mjgte4umvv8penqckqnnu.apps.googleusercontent.com',
    iosClientId: '522987606252-ss0v2bf25p8r9gl2tfill8b429dcdfvg.apps.googleusercontent.com',
    iosBundleId: 'com.fdffare.flyDealFare',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAgJIqMzfrmqvP5kiy3GpvXKPkLmZQN5AM',
    appId: '1:522987606252:ios:673c0e23caf3cf283b95c9',
    messagingSenderId: '522987606252',
    projectId: 'newflydealfare',
    storageBucket: 'newflydealfare.appspot.com',
    androidClientId: '522987606252-368a1qnmm90mjgte4umvv8penqckqnnu.apps.googleusercontent.com',
    iosClientId: '522987606252-ss0v2bf25p8r9gl2tfill8b429dcdfvg.apps.googleusercontent.com',
    iosBundleId: 'com.fdffare.flyDealFare',
  );
}
