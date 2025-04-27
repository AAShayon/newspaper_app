import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

class FirebaseConfig {
  static Future<void> initialize() async {
    try {
      // Initialize Firebase
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      // Enable Firestore persistence
      FirebaseFirestore.instance.settings = Settings(persistenceEnabled: true);
      log("Firestore persistence enabled successfully.");
    } catch (e) {
      log("Error initializing Firebase: $e");
    }
  }
}