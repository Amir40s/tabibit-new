import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:tabibinet_project/Providers/AudioPlayerProvider/audio_player_provider.dart';

class AudioRecorder {
  FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  String? _filePath;

  Future<void> initRecorder() async {
    await _recorder.openRecorder();
  }

  Future<void> startRecording() async {
    Directory tempDir = await getTemporaryDirectory();
    _filePath = '${tempDir.path}/audio.aac';  // Store as .aac format
    await _recorder.startRecorder(
      toFile: _filePath,
      codec: Codec.aacADTS,  // Use a compressed format
    );
  }

  Future<void> stopRecording() async {
    await _recorder.stopRecorder();
  }

  String? get filePath => _filePath;

  // Provide a method to close the recorder
  Future<void> closeRecorder() async {
    await _recorder.closeRecorder();
  }

  // Public method to check if the recorder is running
  bool isRecording() {
    return _recorder.isRecording;
  }
}


Future<String> uploadAudioToFirebase(String filePath,context) async {
  final provider = Provider.of<AudioPlayerProvider>(context,listen: false);
  File audioFile = File(filePath);
  try {
    provider.setLoading(true);
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageRef = FirebaseStorage.instance.ref().child('audios/$fileName.aac');
    await storageRef.putFile(audioFile);
    provider.setLoading(false);
    return await storageRef.getDownloadURL();  // Return URL for future playback
  } catch (e) {
    log('Error uploading audio: $e');
    return provider.setLoading(false);
  }
}


Future<void> requestPermissions() async {
  await Permission.microphone.request();
  await Permission.storage.request();
}


class AudioRecorderScreen extends StatefulWidget {
  const AudioRecorderScreen({super.key});

  @override
  _AudioRecorderScreenState createState() => _AudioRecorderScreenState();
}

class _AudioRecorderScreenState extends State<AudioRecorderScreen> {
  final AudioRecorder _recorder = AudioRecorder();
  bool _isRecording = false;  // Track recording status
  String? _audioUrl;  // To store audio URL from Firebase

  @override
  void initState() {
    super.initState();
    requestPermissions();
    _recorder.initRecorder();
  }

  @override
  void dispose() {
    _recorder._recorder.closeRecorder();
    super.dispose();
  }

  // Handle mic button press
  void _handleMicButton() async {
    if (_isRecording) {
      // Stop recording
      await _recorder.stopRecording();
      String? filePath = _recorder.filePath;

      if (filePath != null) {
        String? url = await uploadAudioToFirebase(filePath,context);  // Upload to Firebase
        if (url != null) {
          setState(() {
            _audioUrl = url;
          });
        }
      }
    } else {
      // Start recording
      await _recorder.startRecording();
    }

    // Toggle recording state and update UI
    setState(() {
      _isRecording = !_isRecording;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio Recorder with Firebase'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Mic Icon Button
            IconButton(
              icon: Icon(
                Icons.mic,
                color: _isRecording ? Colors.red : Colors.black,  // Change color
                size: 60.0,
              ),
              onPressed: _handleMicButton,  // Start/Stop recording
            ),
            SizedBox(height: 20),
            // Display URL if audio was uploaded successfully
            if (_audioUrl != null)
              Text(
                'Audio Uploaded! URL: $_audioUrl',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}