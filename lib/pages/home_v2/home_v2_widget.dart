import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/story_card_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_v2_model.dart';
export 'home_v2_model.dart';

class HomeV2Widget extends StatefulWidget {
  const HomeV2Widget({Key? key}) : super(key: key);

  @override
  _HomeV2WidgetState createState() => _HomeV2WidgetState();
}

class _HomeV2WidgetState extends State<HomeV2Widget> {
  late HomeV2Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeV2Model());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        floatingActionButton: FloatingActionButton(
          key: ValueKey('AddNewFAB_sf2x'),
          onPressed: () async {
            _model.currentStoryDoc = await queryDailyStoryRecordOnce(
              queryBuilder: (dailyStoryRecord) => dailyStoryRecord.where(
                'dateSegment',
                isEqualTo: functions.getCurrentDateSegment(),
              ),
              singleRecord: true,
            ).then((s) => s.firstOrNull);
            if (_model.currentStoryDoc != null) {
              _model.currentDayStory = _model.currentStoryDoc;
            } else {
              var dailyStoryRecordReference = DailyStoryRecord.collection.doc();
              await dailyStoryRecordReference.set({
                ...createDailyStoryRecordData(
                  aiProcessed: false,
                  dateSegment: functions.getCurrentDateSegment(),
                  numberOfSubNotes: 0,
                  user: currentUserReference,
                  userId: currentUserUid,
                  title: '',
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
                  title: '',
                ),
                ...mapToFirestore(
                  {
                    'lastUpdatedAt': DateTime.now(),
                  },
                ),
              }, dailyStoryRecordReference);

              await currentUserReference!.update({
                ...mapToFirestore(
                  {
                    'numberOfStories': FieldValue.increment(1),
                  },
                ),
              });
              _model.currentDayStory = _model.newDailyStory;
            }

            var subPieceNoteRecordReference =
                SubPieceNoteRecord.collection.doc();
            await subPieceNoteRecordReference.set({
              ...createSubPieceNoteRecordData(
                user: currentUserReference,
                storyId: _model.currentDayStory?.reference.id,
                noteTime: dateTimeFormat('y/M/d H:mm', getCurrentTimestamp),
              ),
              ...mapToFirestore(
                {
                  'createdTime': FieldValue.serverTimestamp(),
                  'lastUpdatedAt': FieldValue.serverTimestamp(),
                },
              ),
            });
            _model.subNoteOutput = SubPieceNoteRecord.getDocumentFromData({
              ...createSubPieceNoteRecordData(
                user: currentUserReference,
                storyId: _model.currentDayStory?.reference.id,
                noteTime: dateTimeFormat('y/M/d H:mm', getCurrentTimestamp),
              ),
              ...mapToFirestore(
                {
                  'createdTime': DateTime.now(),
                  'lastUpdatedAt': DateTime.now(),
                },
              ),
            }, subPieceNoteRecordReference);

            await currentUserReference!.update({
              ...mapToFirestore(
                {
                  'numberOfSubNotes': FieldValue.increment(1),
                },
              ),
            });

            await _model.currentDayStory!.reference.update({
              ...createDailyStoryRecordData(
                lastUpdatedAt: getCurrentTimestamp,
              ),
              ...mapToFirestore(
                {
                  'numberOfSubNotes': FieldValue.increment(1),
                },
              ),
            });

            context.pushNamed(
              'SubNoteWriting',
              queryParameters: {
                'subNote': serializeParam(
                  _model.subNoteOutput,
                  ParamType.Document,
                ),
                'addNew': serializeParam(
                  true,
                  ParamType.bool,
                ),
              }.withoutNulls,
              extra: <String, dynamic>{
                'subNote': _model.subNoteOutput,
              },
            );

            setState(() {});
          },
          backgroundColor: FlutterFlowTheme.of(context).primary,
          elevation: 8.0,
          child: Icon(
            Icons.add_rounded,
            color: FlutterFlowTheme.of(context).primaryText,
            size: 24.0,
          ),
        ),
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.sizeOf(context).height * 0.1),
          child: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            automaticallyImplyLeading: false,
            title: Text(
              'All',
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    fontFamily: 'Outfit',
                    color: FlutterFlowTheme.of(context).primaryText,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            actions: [],
            centerTitle: false,
            elevation: 1.0,
          ),
        ),
        body: SafeArea(
          top: true,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).primaryBackground,
            ),
            child: StreamBuilder<List<DailyStoryRecord>>(
              stream: queryDailyStoryRecord(
                queryBuilder: (dailyStoryRecord) => dailyStoryRecord
                    .where(
                      'user',
                      isEqualTo: currentUserReference,
                    )
                    .orderBy('dateSegment', descending: true),
              ),
              builder: (context, snapshot) {
                // Customize what your widget looks like when it's loading.
                if (!snapshot.hasData) {
                  return Center(
                    child: SizedBox(
                      width: 50.0,
                      height: 50.0,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          FlutterFlowTheme.of(context).primary,
                        ),
                      ),
                    ),
                  );
                }
                List<DailyStoryRecord> listViewDailyStoryRecordList =
                    snapshot.data!;
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  itemCount: listViewDailyStoryRecordList.length,
                  itemBuilder: (context, listViewIndex) {
                    final listViewDailyStoryRecord =
                        listViewDailyStoryRecordList[listViewIndex];
                    return InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        context.pushNamed(
                          'StoryDetail',
                          queryParameters: {
                            'storyDoc': serializeParam(
                              listViewDailyStoryRecord,
                              ParamType.Document,
                            ),
                          }.withoutNulls,
                          extra: <String, dynamic>{
                            'storyDoc': listViewDailyStoryRecord,
                            kTransitionInfoKey: TransitionInfo(
                              hasTransition: true,
                              transitionType: PageTransitionType.bottomToTop,
                            ),
                          },
                        );
                      },
                      child: StoryCardWidget(
                        key: Key(
                            'Key6r3_${listViewIndex}_of_${listViewDailyStoryRecordList.length}'),
                        story: listViewDailyStoryRecord,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
