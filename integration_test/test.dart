import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:compose_mate/main.dart';
import 'package:compose_mate/flutter_flow/flutter_flow_util.dart';

import 'package:provider/provider.dart';
import 'package:compose_mate/backend/firebase/firebase_config.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('CreateNewStory', (WidgetTester tester) async {
    _overrideOnError();
    await initFirebase();
    await FirebaseAuth.instance.signOut();
    FFAppState.reset();
    final appState = FFAppState();
    await appState.initializePersistedState();

    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: 'yhfy2013@gmail.com', password: 'mym881115');
    await tester.pumpWidget(ChangeNotifierProvider(
      create: (context) => appState,
      child: MyApp(),
    ));

    await tester.tap(find.byKey(ValueKey('AddNewFAB_sf2x')));
    await tester.enterText(find.byKey(ValueKey('NoteField_8ag4')),
        'Today\'s work plan as an accountant: In the morning, I\'ll first check newly submitted invoices and expense reports, followed by the preparation of the monthly financial statement. In the afternoon, there\'s a team meeting to discuss the annual budget and financial planning for the next quarter. I aim to reply to all pending emails before the day ends.');
    await tester.tap(find.byKey(ValueKey('IconButton_9dbx')));
    await tester.tap(find.byKey(ValueKey('AddNewFAB_sf2x')));
    await tester.enterText(find.byKey(ValueKey('NoteField_8ag4')),
        'For lunch, my colleagues and I tried a restaurant named \'Fatty Girl\'. The ambiance was cozy, and the food was commendable. Their signature dish, \'Fatty Girl Special Fried Rice\', was particularly notable. Definitely worth revisiting.');
  });
}

// There are certain types of errors that can happen during tests but
// should not break the test.
void _overrideOnError() {
  final originalOnError = FlutterError.onError!;
  FlutterError.onError = (errorDetails) {
    if (_shouldIgnoreError(errorDetails.toString())) {
      return;
    }
    originalOnError(errorDetails);
  };
}

bool _shouldIgnoreError(String error) {
  // It can fail to decode some SVGs - this should not break the test.
  if (error.contains('ImageCodecException')) {
    return true;
  }
  // Overflows happen all over the place,
  // but they should not break tests.
  if (error.contains('overflowed by')) {
    return true;
  }
  // Sometimes some images fail to load, it generally does not break the test.
  if (error.contains('No host specified in URI') ||
      error.contains('EXCEPTION CAUGHT BY IMAGE RESOURCE SERVICE')) {
    return true;
  }
  // These errors should be avoided, but they should not break the test.
  if (error.contains('setState() called after dispose()')) {
    return true;
  }

  return false;
}
