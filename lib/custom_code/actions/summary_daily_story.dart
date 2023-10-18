// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the button on the right!
import 'package:cloud_functions/cloud_functions.dart';

Future<void> summaryDailyStory(String storyId) async {
  final HttpsCallable callable = FirebaseFunctions.instance
      .httpsCallable('on_date_segment_gpt_summary_on_call');
  try {
    final result = await callable.call({'storyId': storyId});
    print(result.data);
  } on FirebaseFunctionsException catch (e) {
    print('Error: ${e.code} ${e.message}');
  } catch (e) {
    print('Error: $e');
  }
}
