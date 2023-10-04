import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'profile_collection_widget.dart' show ProfileCollectionWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfileCollectionModel extends FlutterFlowModel<ProfileCollectionWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for namefield widget.
  TextEditingController? namefieldController;
  String? Function(BuildContext, String?)? namefieldControllerValidator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
    namefieldController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
