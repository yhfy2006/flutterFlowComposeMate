import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/story_card_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'home_v2_widget.dart' show HomeV2Widget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeV2Model extends FlutterFlowModel<HomeV2Widget> {
  ///  Local state fields for this page.

  DailyStoryRecord? currentDayStory;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Firestore Query - Query a collection] action in AddNewFAB widget.
  DailyStoryRecord? currentStoryDoc;
  // Stores action output result for [Backend Call - Create Document] action in AddNewFAB widget.
  DailyStoryRecord? newDailyStory;
  // Stores action output result for [Backend Call - Create Document] action in AddNewFAB widget.
  SubPieceNoteRecord? subNoteOutput;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
