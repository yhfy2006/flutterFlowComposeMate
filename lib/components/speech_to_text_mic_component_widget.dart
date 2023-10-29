import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'speech_to_text_mic_component_model.dart';
export 'speech_to_text_mic_component_model.dart';

class SpeechToTextMicComponentWidget extends StatefulWidget {
  const SpeechToTextMicComponentWidget({Key? key}) : super(key: key);

  @override
  _SpeechToTextMicComponentWidgetState createState() =>
      _SpeechToTextMicComponentWidgetState();
}

class _SpeechToTextMicComponentWidgetState
    extends State<SpeechToTextMicComponentWidget> {
  late SpeechToTextMicComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SpeechToTextMicComponentModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Align(
      alignment: AlignmentDirectional(0.00, 1.00),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
        child: Container(
          width: double.infinity,
          height: 200.0,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).primaryBackground,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Lottie.asset(
            'assets/lottie_animations/recording.json',
            width: 150.0,
            height: 130.0,
            fit: BoxFit.none,
            animate: true,
          ),
        ),
      ),
    );
  }
}
