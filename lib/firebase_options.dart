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
    apiKey: 'AIzaSyBFKU3wgd6IFEjVzJ9w_oaD5NCsHTJJg8I',
    appId: '1:377553949:web:453192458dcfafa9d9b2f4',
    messagingSenderId: '377553949',
    projectId: 'total-x-project-b89a1',
    authDomain: 'total-x-project-b89a1.firebaseapp.com',
    storageBucket: 'total-x-project-b89a1.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB2EXlTgCXPDFL7ZZQDbqe8GSEWNONEs2c',
    appId: '1:377553949:android:6515c4d6d1dd9937d9b2f4',
    messagingSenderId: '377553949',
    projectId: 'total-x-project-b89a1',
    storageBucket: 'total-x-project-b89a1.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAMfbqhY1omX5tF1I_IY2e0v3bxxb7MabU',
    appId: '1:377553949:ios:b7115c3b129752b3d9b2f4',
    messagingSenderId: '377553949',
    projectId: 'total-x-project-b89a1',
    storageBucket: 'total-x-project-b89a1.firebasestorage.app',
    iosBundleId: 'com.example.totalxProject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAMfbqhY1omX5tF1I_IY2e0v3bxxb7MabU',
    appId: '1:377553949:ios:b7115c3b129752b3d9b2f4',
    messagingSenderId: '377553949',
    projectId: 'total-x-project-b89a1',
    storageBucket: 'total-x-project-b89a1.firebasestorage.app',
    iosBundleId: 'com.example.totalxProject',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBFKU3wgd6IFEjVzJ9w_oaD5NCsHTJJg8I',
    appId: '1:377553949:web:21fdd2ae2f0c524bd9b2f4',
    messagingSenderId: '377553949',
    projectId: 'total-x-project-b89a1',
    authDomain: 'total-x-project-b89a1.firebaseapp.com',
    storageBucket: 'total-x-project-b89a1.firebasestorage.app',
  );
}
