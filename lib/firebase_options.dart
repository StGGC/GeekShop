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
        return windows;
      case TargetPlatform.linux:
        return linux;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyChJq4FRqAGWwDXGdB-su6oWfBwswV9jCk',
    appId: '1:772339533564:web:8c5ddf2045c07bf6647979',
    messagingSenderId: '772339533564',
    projectId: 'prt2b-6f7d3',
    authDomain: 'prt2b-6f7d3.firebaseapp.com',
    storageBucket: 'prt2b-6f7d3.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCzom_DM9WKaKjb9U93WWb_PPmzknmeFFU',
    appId: '1:772339533564:android:6477395bcbf0db34647979',
    messagingSenderId: '772339533564',
    projectId: 'prt2b-6f7d3',
    storageBucket: 'prt2b-6f7d3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyChLtkiJcusuVjEKObbq3C8HFPIai2WVAE',
    appId: '1:772339533564:ios:6691a561007a1c1d647979',
    messagingSenderId: '772339533564',
    projectId: 'prt2b-6f7d3',
    storageBucket: 'prt2b-6f7d3.appspot.com',
    iosClientId:
        '772339533564-jitd06u5dbp3k089d9q0can35ldb6qii.apps.googleusercontent.com',
    iosBundleId: 'com.example.text',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyChJq4FRqAGWwDXGdB-su6oWfBwswV9jCk',
    appId: '1:772339533564:web:f979aa06feb412bc647979',
    messagingSenderId: '772339533564',
    projectId: 'prt2b-6f7d3',
    authDomain: 'prt2b-6f7d3.firebaseapp.com',
    storageBucket: 'prt2b-6f7d3.appspot.com',
  );

  static const FirebaseOptions linux = FirebaseOptions(
    apiKey: 'AIzaSyChJq4FRqAGWwDXGdB-su6oWfBwswV9jCk',
    appId: '1:772339533564:web:1d34917742567dfc647979',
    messagingSenderId: '772339533564',
    projectId: 'prt2b-6f7d3',
    authDomain: 'prt2b-6f7d3.firebaseapp.com',
    storageBucket: 'prt2b-6f7d3.appspot.com',
  );
}
