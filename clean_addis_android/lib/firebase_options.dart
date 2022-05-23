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
    apiKey: 'AIzaSyABVNj_MCi3jHoYwyCzHD_zQT8cbElE-QA',
    appId: '1:91525154925:web:7aaf6f75df4b1361105764',
    messagingSenderId: '91525154925',
    projectId: 'cleanaddis-b7388',
    authDomain: 'cleanaddis-b7388.firebaseapp.com',
    storageBucket: 'cleanaddis-b7388.appspot.com',
    measurementId: 'G-TTEB40D2S0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD82BRuZoUCIAWodFHsenedgIoAfVkna2w',
    appId: '1:91525154925:android:2b82597b59872fe2105764',
    messagingSenderId: '91525154925',
    projectId: 'cleanaddis-b7388',
    storageBucket: 'cleanaddis-b7388.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCkG3FkUi4VSRNTvy_n1nKg2D-vcAabhjc',
    appId: '1:91525154925:ios:6cc0eff23a26ef5b105764',
    messagingSenderId: '91525154925',
    projectId: 'cleanaddis-b7388',
    storageBucket: 'cleanaddis-b7388.appspot.com',
    iosClientId: '91525154925-65ja42qood04f7fnf46um89pnpkm5ied.apps.googleusercontent.com',
    iosBundleId: 'com.example.cleanAddisAndroid',
  );
}