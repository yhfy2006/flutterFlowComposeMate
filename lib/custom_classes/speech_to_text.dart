import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class Stt {
  final SpeechToText _speechToText = SpeechToText();
  TextEditingController textEditingController;
  bool speechEnabled = false;
  bool speechStart = false;
  bool speechLoading = false;
  Stt({required this.textEditingController});
  String previousText = "";

  Future start(Function? callBack) async {
    if (!speechEnabled) {
      speechEnabled = await _speechToText.initialize();
    }

    if (speechEnabled) {
      speechStart = true;
      previousText = textEditingController.text;

      return _speechToText.listen(onResult: (result) {
        // if (!result.finalResult) {
        //   pageStage.setState(() {
        //     textEditingController.text = previousText + result.recognizedWords;
        //   });
        // } else {
        //   pageStage.setState(() {
        //     textEditingController.text = previousText + result.recognizedWords;
        //   });
        // }
        textEditingController.text = previousText + result.recognizedWords;
        callBack?.call();
      });
    } else {
      return Future.error('Speech to text not enabled');
    }
  }

  Future stop() async {
    await _speechToText.stop();
    speechStart = false;
  }
}
