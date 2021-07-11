import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:mltext/provider/imageUplod.dart';

class TextToSpeech extends StatefulWidget {
  final String scanText;

  const TextToSpeech({Key? key, required this.scanText}) : super(key: key);
  @override
  _TextToSpeechState createState() => _TextToSpeechState();
}

enum TtsState { playing, stopped }

class _TextToSpeechState extends State<TextToSpeech> {
  late FlutterTts flutterTts;

  double volume = 0.5;
  double pitch = 1.0;
  double rate = 0.5;

  String _newVoiceText = "The Recoganised Text";

  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;

  get isStopped => ttsState == TtsState.stopped;

  @override
  initState() {
    super.initState();

    initTts();
    setState(() {
      _newVoiceText = getTextRes();
    });
  }

  initTts() {
    flutterTts = FlutterTts();

    flutterTts.setStartHandler(() {
      setState(() {
        print("playing");
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        print("Complete");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        print("error: $msg");
        ttsState = TtsState.stopped;
      });
    });
  }

  Future _speak() async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);
    print("_newVoiceText");

    if (_newVoiceText.isNotEmpty) {
      var result =
          await flutterTts.speak("${_newVoiceText.replaceAll("\\n", " ")}");
      if (result == 1) setState(() => ttsState = TtsState.playing);
    }
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    _newVoiceText = getTextRes();
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: bottomBar(),
      appBar: AppBar(
        title: Text(
          'Recognized Text',
          style: TextStyle(color: Colors.blue),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "${_newVoiceText.replaceAll("\\n", " ")}",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }

  bottomBar() => Container(
        margin: EdgeInsets.all(10.0),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FloatingActionButton(
              heroTag: "nmb",
              onPressed: _speak,
              child: Icon(Icons.play_arrow),
              backgroundColor: Colors.green,
            ),
            FloatingActionButton(
              heroTag: "n6",
              onPressed: _stop,
              backgroundColor: Colors.red,
              child: Icon(Icons.stop),
            ),
          ],
        ),
      );
}
