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
    apiKey: 'AIzaSyBbf9PF9O1wpnbolEIc8ORfk51WsBWl0O8',
    appId: '1:589602296410:web:1609b8b869acb8d9e8fe63',
    messagingSenderId: '589602296410',
    projectId: 'livit-1904',
    authDomain: 'livit-1904.firebaseapp.com',
    storageBucket: 'livit-1904.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDTNECEUkRrG-V_7d-ZfN89aCNhqnPcd1k',
    appId: '1:589602296410:android:94f3f8440ccb0669e8fe63',
    messagingSenderId: '589602296410',
    projectId: 'livit-1904',
    storageBucket: 'livit-1904.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDWrX1ItV_BrePkXO8MsWzYqRwjB1EG0E0',
    appId: '1:589602296410:ios:a4605115306d37e0e8fe63',
    messagingSenderId: '589602296410',
    projectId: 'livit-1904',
    storageBucket: 'livit-1904.appspot.com',
    iosBundleId: 'com.example.livit',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDWrX1ItV_BrePkXO8MsWzYqRwjB1EG0E0',
    appId: '1:589602296410:ios:999ca0c201bd7c63e8fe63',
    messagingSenderId: '589602296410',
    projectId: 'livit-1904',
    storageBucket: 'livit-1904.appspot.com',
    iosBundleId: 'com.example.livit.RunnerTests',
  );
}
