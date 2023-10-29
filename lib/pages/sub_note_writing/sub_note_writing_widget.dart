import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/speech_to_text_mic_component_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'sub_note_writing_model.dart';
export 'sub_note_writing_model.dart';

class SubNoteWritingWidget extends StatefulWidget {
  const SubNoteWritingWidget({
    Key? key,
    required this.subNote,
    bool? addNew,
  })  : this.addNew = addNew ?? false,
        super(key: key);

  final SubPieceNoteRecord? subNote;
  final bool addNew;

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
      if (widget.addNew) {
        showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          enableDrag: false,
          context: context,
          builder: (context) {
            return GestureDetector(
              onTap: () => _model.unfocusNode.canRequestFocus
                  ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                  : FocusScope.of(context).unfocus(),
              child: Padding(
                padding: MediaQuery.viewInsetsOf(context),
                child: SpeechToTextMicComponentWidget(),
              ),
            );
          },
        ).then((value) => safeSetState(() {}));
      } else {
        await showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          enableDrag: false,
          context: context,
          builder: (context) {
            return GestureDetector(
              onTap: () => _model.unfocusNode.canRequestFocus
                  ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                  : FocusScope.of(context).unfocus(),
              child: Padding(
                padding: MediaQuery.viewInsetsOf(context),
                child: SpeechToTextMicComponentWidget(),
              ),
            );
          },
        ).then((value) => safeSetState(() {}));

        await actions.speechToText();
      }
    });

    _model.noteFieldController ??= TextEditingController(
        text:
            '${widget.subNote?.text}${FFAppState().sstSendText != null && FFAppState().sstSendText != '' ? FFAppState().sstSendText : FFAppState().stt}');
    _model.noteFieldFocusNode ??= FocusNode();
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
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
                      child: TextFormField(
                        key: ValueKey('NoteField_8ag4'),
                        controller: _model.noteFieldController,
                        focusNode: _model.noteFieldFocusNode,
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
            ],
          ),
        ),
      ),
    );
  }
}
