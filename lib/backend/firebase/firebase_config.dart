import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyAvc8VjALuMKvifyLF7YkFLEQT1gx5ESC4",
            authDomain: "composemate.firebaseapp.com",
            projectId: "composemate",
            storageBucket: "composemate.appspot.com",
            messagingSenderId: "195905407223",
            appId: "1:195905407223:web:c148ad2c3b3a18db0d2bf2",
            measurementId: "G-CJVBWNB06M"));
  } else {
    await Firebase.initializeApp();
  }
}
