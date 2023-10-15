import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'sub_note_writing_model.dart';
export 'sub_note_writing_model.dart';

class SubNoteWritingWidget extends StatefulWidget {
  const SubNoteWritingWidget({
    Key? key,
    required this.subNote,
  }) : super(key: key);

  final SubPieceNoteRecord? subNote;

  @override
  _SubNoteWritingWidgetState createState() => _SubNoteWritingWidgetState();
}

class _SubNoteWritingWidgetState extends State<SubNoteWritingWidget> {
  late SubNoteWritingModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SubNoteWritingModel());

    _model.noteFieldController ??=
        TextEditingController(text: widget.subNote?.text);
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return StreamBuilder<List<DailyStoryRecord>>(
      stream: queryDailyStoryRecord(
        queryBuilder: (dailyStoryRecord) => dailyStoryRecord.where(
          'dateSegment',
          isEqualTo: functions.getCurrentDateSegment(),
        ),
        singleRecord: true,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        List<DailyStoryRecord> subNoteWritingDailyStoryRecordList =
            snapshot.data!;
        // Return an empty Container when the item does not exist.
        if (snapshot.data!.isEmpty) {
          return Container();
        }
        final subNoteWritingDailyStoryRecord =
            subNoteWritingDailyStoryRecordList.isNotEmpty
                ? subNoteWritingDailyStoryRecordList.first
                : null;
        return GestureDetector(
          onTap: () => _model.unfocusNode.canRequestFocus
              ? FocusScope.of(context).requestFocus(_model.unfocusNode)
              : FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
              automaticallyImplyLeading: false,
              leading: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30.0,
                borderWidth: 1.0,
                buttonSize: 60.0,
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 30.0,
                ),
                onPressed: () async {
                  context.pop();
                },
              ),
              title: Text(
                dateTimeFormat('MMMEd', getCurrentTimestamp),
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: 'Outfit',
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 22.0,
                    ),
              ),
              actions: [
                FlutterFlowIconButton(
                  key: ValueKey('IconButton_9dbx'),
                  borderRadius: 20.0,
                  borderWidth: 1.0,
                  buttonSize: 51.0,
                  icon: Icon(
                    key: ValueKey('IconButton_9dbx'),
                    Icons.check_sharp,
                    color: Color(0x00000000),
                    size: 28.0,
                  ),
                  onPressed: () async {
                    // has text in note.
                    if (_model.noteFieldController.text.isNotEmpty) {
                      await widget.subNote!.reference.update({
                        ...createSubPieceNoteRecordData(
                          text: _model.noteFieldController.text,
                        ),
                        ...mapToFirestore(
                          {
                            'lastUpdatedAt': FieldValue.serverTimestamp(),
                          },
                        ),
                      });
                    }
                    context.safePop();
                  },
                ),
              ],
              centerTitle: false,
              elevation: 1.0,
            ),
            body: SafeArea(
              top: true,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
                      child: TextFormField(
                        key: ValueKey('NoteField_8ag4'),
                        controller: _model.noteFieldController,
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: 'write your quick note',
                          hintStyle:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: Color(0x4057636C),
                                    fontSize: 20.0,
                                  ),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Readex Pro',
                              fontSize: 20.0,
                              lineHeight: 1.8,
                            ),
                        textAlign: TextAlign.start,
                        maxLines: null,
                        cursorColor: FlutterFlowTheme.of(context).primary,
                        validator: _model.noteFieldControllerValidator
                            .asValidator(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
