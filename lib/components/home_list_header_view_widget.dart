import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_list_header_view_model.dart';
export 'home_list_header_view_model.dart';

class HomeListHeaderViewWidget extends StatefulWidget {
  const HomeListHeaderViewWidget({Key? key}) : super(key: key);

  @override
  _HomeListHeaderViewWidgetState createState() =>
      _HomeListHeaderViewWidgetState();
}

class _HomeListHeaderViewWidgetState extends State<HomeListHeaderViewWidget> {
  late HomeListHeaderViewModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeListHeaderViewModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
      child: Container(
        width: double.infinity,
        height: 50.0,
        decoration: BoxDecoration(),
        child: Align(
          alignment: AlignmentDirectional(-1.00, 0.00),
          child: Text(
            'Mar 23',
            textAlign: TextAlign.start,
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Readex Pro',
                  color: FlutterFlowTheme.of(context).secondaryText,
                  fontSize: 20.0,
                ),
          ),
        ),
      ),
    );
  }
}
