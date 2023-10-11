import '/backend/backend.dart';
import '/components/sub_note_display_cell_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'sub_notes_list_model.dart';
export 'sub_notes_list_model.dart';

class SubNotesListWidget extends StatefulWidget {
  const SubNotesListWidget({
    Key? key,
    required this.storyId,
  }) : super(key: key);

  final String? storyId;

  @override
  _SubNotesListWidgetState createState() => _SubNotesListWidgetState();
}

class _SubNotesListWidgetState extends State<SubNotesListWidget> {
  late SubNotesListModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SubNotesListModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
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
            'SubNotes',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Outfit',
                  color: Colors.white,
                  fontSize: 22.0,
                ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: StreamBuilder<List<SubPieceNoteRecord>>(
            stream: querySubPieceNoteRecord(
              queryBuilder: (subPieceNoteRecord) => subPieceNoteRecord
                  .where(
                    'storyId',
                    isEqualTo: widget.storyId,
                  )
                  .orderBy('createdTime', descending: true),
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
              List<SubPieceNoteRecord> listViewSubPieceNoteRecordList =
                  snapshot.data!;
              return ListView.builder(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                itemCount: listViewSubPieceNoteRecordList.length,
                itemBuilder: (context, listViewIndex) {
                  final listViewSubPieceNoteRecord =
                      listViewSubPieceNoteRecordList[listViewIndex];
                  return SubNoteDisplayCellWidget(
                    key: Key(
                        'Keyrqa_${listViewIndex}_of_${listViewSubPieceNoteRecordList.length}'),
                    subNoteDoc: listViewSubPieceNoteRecord,
                    subNoteRef: listViewSubPieceNoteRecord.reference,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
