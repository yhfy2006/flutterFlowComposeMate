import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'sub_note_writing_model.dart';
export 'sub_note_writing_model.dart';

class SubNoteWritingWidget extends StatefulWidget {
  const SubNoteWritingWidget({Key? key}) : super(key: key);

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

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.dailyStoryDoc = await queryDailyStoryRecordOnce(
        queryBuilder: (dailyStoryRecord) => dailyStoryRecord.where(
          'dateSegment',
          isEqualTo: functions.getCurrentDateSegment(),
        ),
        singleRecord: true,
      ).then((s) => s.firstOrNull);
      if (_model.dailyStoryDoc != null) {
        setState(() {
          _model.dailyStory = _model.dailyStoryDoc;
          _model.dailyStoryRef = _model.dailyStoryDoc?.reference;
        });
      } else {
        var dailyStoryRecordReference = DailyStoryRecord.collection.doc();
        await dailyStoryRecordReference.set({
          ...createDailyStoryRecordData(
            aiProcessed: false,
            dateSegment: functions.getCurrentDateSegment(),
            numberOfSubNotes: 0,
            user: currentUserReference,
            userId: currentUserUid,
          ),
          ...mapToFirestore(
            {
              'lastUpdatedAt': FieldValue.serverTimestamp(),
            },
          ),
        });
        _model.newDailyStory = DailyStoryRecord.getDocumentFromData({
          ...createDailyStoryRecordData(
            aiProcessed: false,
            dateSegment: functions.getCurrentDateSegment(),
            numberOfSubNotes: 0,
            user: currentUserReference,
            userId: currentUserUid,
          ),
          ...mapToFirestore(
            {
              'lastUpdatedAt': DateTime.now(),
            },
          ),
        }, dailyStoryRecordReference);
        setState(() {
          _model.dailyStory = _model.newDailyStory;
        });

        await currentUserReference!.update({
          ...mapToFirestore(
            {
              'numberOfStories': FieldValue.increment(1),
            },
          ),
        });
      }
    });

    _model.noteFieldController ??= TextEditingController();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
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
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
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
                  borderRadius: 20.0,
                  borderWidth: 1.0,
                  buttonSize: 51.0,
                  icon: Icon(
                    Icons.check_sharp,
                    color: Color(0x00000000),
                    size: 28.0,
                  ),
                  onPressed: () async {
                    // has text in note.
                    if (_model.noteFieldController.text.isNotEmpty) {
                      await SubPieceNoteRecord.collection
                          .doc()
                          .set(createSubPieceNoteRecordData(
                            text: _model.noteFieldController.text,
                            user: currentUserReference,
                            storyId: _model.dailyStory?.reference.id,
                          ));

                      await currentUserReference!.update({
                        ...mapToFirestore(
                          {
                            'numberOfSubNotes': FieldValue.increment(1),
                          },
                        ),
                      });

                      await _model.dailyStoryRef!.update({
                        ...mapToFirestore(
                          {
                            'lastUpdatedAt': FieldValue.serverTimestamp(),
                            'numberOfSubNotes': FieldValue.increment(1),
                          },
                        ),
                      });
                      context.safePop();
                    } else {
                      context.safePop();
                    }
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
