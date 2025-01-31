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
    apiKey: 'AIzaSyBj2EyGYhDZ-bw1bKsgioqxMvhdWoFzcb4',
    appId: '1:1042834218331:web:e7bf6e10afbc6bd2588e7e',
    messagingSenderId: '1042834218331',
    projectId: 'bank-sat-bcfe7',
    authDomain: 'bank-sat-bcfe7.firebaseapp.com',
    storageBucket: 'bank-sat-bcfe7.firebasestorage.app',
    measurementId: 'G-YBR2YHXW9V',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDK__YyF2N9P8Itp_LsABvcZyemJg0Kfpo',
    appId: '1:1042834218331:android:dfd2f1eef19f241c588e7e',
    messagingSenderId: '1042834218331',
    projectId: 'bank-sat-bcfe7',
    storageBucket: 'bank-sat-bcfe7.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB6pcwU9clDk_oZZoghzlTshMRXqxH7xGA',
    appId: '1:1042834218331:ios:3a136fb4c75b1a75588e7e',
    messagingSenderId: '1042834218331',
    projectId: 'bank-sat-bcfe7',
    storageBucket: 'bank-sat-bcfe7.firebasestorage.app',
    iosBundleId: 'com.example.bankSat',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB6pcwU9clDk_oZZoghzlTshMRXqxH7xGA',
    appId: '1:1042834218331:ios:3a136fb4c75b1a75588e7e',
    messagingSenderId: '1042834218331',
    projectId: 'bank-sat-bcfe7',
    storageBucket: 'bank-sat-bcfe7.firebasestorage.app',
    iosBundleId: 'com.example.bankSat',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBj2EyGYhDZ-bw1bKsgioqxMvhdWoFzcb4',
    appId: '1:1042834218331:web:75cd64ff6bfeadd4588e7e',
    messagingSenderId: '1042834218331',
    projectId: 'bank-sat-bcfe7',
    authDomain: 'bank-sat-bcfe7.firebaseapp.com',
    storageBucket: 'bank-sat-bcfe7.firebasestorage.app',
    measurementId: 'G-74LYEJW65S',
  );
}
