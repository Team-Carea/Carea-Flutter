import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:google_speech/google_speech.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';

const int kAudioSampleRate = 16000;
const int kAudioNumChannels = 1;

class SttService {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  bool isRecognizing = false;
  bool isRecognizeFinished = false;
  StreamSubscription<List<int>>? _audioStreamSubscription;
  BehaviorSubject<List<int>>? _audioStream;
  StreamController<Food>? _recordingDataController;
  StreamSubscription? _recordingDataSubscription;
  Function? onRecognizingStarted;
  Function? onResultReceived;
  Function? onRecognizingStopped;

  void streamingRecognize() async {
    await _recorder.openAudioSession();
    // Stream to be consumed by speech recognizer
    _audioStream = BehaviorSubject<List<int>>();

    // Create recording stream
    _recordingDataController = StreamController<Food>();
    _recordingDataSubscription =
        _recordingDataController?.stream.listen((buffer) {
      if (buffer is FoodData) {
        _audioStream!.add(buffer.data!);
      }
    });

    // isRecognizing 상태값 true로 변경
    onRecognizingStarted!();

    await Permission.microphone.request();

    await _recorder.startRecorder(
        toStream: _recordingDataController!.sink,
        codec: Codec.pcm16,
        numChannels: kAudioNumChannels,
        sampleRate: kAudioSampleRate);

    final serviceAccount = ServiceAccount.fromString(
        (await rootBundle.loadString('asset/google_api_service_account.json')));
    final speechToText = SpeechToText.viaServiceAccount(serviceAccount);

    final config = _getConfig();

    final responseStream = speechToText.streamingRecognize(
        StreamingRecognitionConfig(config: config, interimResults: true),
        _audioStream!);

    var responseText = '';

    responseStream.listen((data) {
      final currentText =
          data.results.map((e) => e.alternatives.first.transcript).join('\n');

      if (data.results.first.isFinal) {
        responseText += '\n$currentText';
        isRecognizeFinished = true;

        onResultReceived?.call(responseText, isRecognizeFinished);
      } else {
        responseText = '$responseText\n$currentText';
        isRecognizeFinished = true;

        onResultReceived?.call(responseText, isRecognizeFinished);
      }
    }, onDone: () {
      onRecognizingStopped!();
    });
  }

  void stopRecording() async {
    await _recorder.stopRecorder();
    await _audioStreamSubscription?.cancel();
    await _audioStream?.close();
    await _recordingDataSubscription?.cancel();
    onRecognizingStopped!();
  }

  RecognitionConfig _getConfig() => RecognitionConfig(
      encoding: AudioEncoding.LINEAR16,
      model: RecognitionModel.basic,
      enableAutomaticPunctuation: true,
      sampleRateHertz: 16000,
      languageCode: 'ko-KR');
}
