
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;


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
    apiKey: 'AIzaSyCiD_md8dmyfiJTAESHgqRAR0ndLvvuTao',
    appId: '1:855526863824:web:e6b126e8038c9d8a8ebfd5',
    messagingSenderId: '855526863824',
    projectId: 'todolist-61d10',
    authDomain: 'todolist-61d10.firebaseapp.com',
    storageBucket: 'todolist-61d10.appspot.com',
    measurementId: 'G-BZJ8FF985Z',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDwmII_wRi2gWTj6fN6dfChB7SJYjq1wZk',
    appId: '1:855526863824:android:2db4e3cda600f0438ebfd5',
    messagingSenderId: '855526863824',
    projectId: 'todolist-61d10',
    storageBucket: 'todolist-61d10.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAvrTWmd6IYGWrRcslA-bBFcjA6lIdaZ7I',
    appId: '1:855526863824:ios:f04656b938472b128ebfd5',
    messagingSenderId: '855526863824',
    projectId: 'todolist-61d10',
    storageBucket: 'todolist-61d10.appspot.com',
    iosBundleId: 'com.gaebaribari.todolist',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAvrTWmd6IYGWrRcslA-bBFcjA6lIdaZ7I',
    appId: '1:855526863824:ios:967ca6190590b9b18ebfd5',
    messagingSenderId: '855526863824',
    projectId: 'todolist-61d10',
    storageBucket: 'todolist-61d10.appspot.com',
    iosBundleId: 'com.gaebaribari.todolist.RunnerTests',
  );
}
