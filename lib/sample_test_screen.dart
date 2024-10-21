import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/controller/audioController.dart';

import 'Providers/agora/webrtc_provider.dart';


class CallScreen extends StatefulWidget {
  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  final TextEditingController _callIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final callProvider = Provider.of<CallProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('WebRTC Video Call')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _callIdController,
              decoration: InputDecoration(
                labelText: 'Enter Call ID',
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_callIdController.text.isNotEmpty) {
                      callProvider.startCall(_callIdController.text.trim());
                    }
                  },
                  child: Text('Start Call'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    if (_callIdController.text.isNotEmpty) {
                      callProvider.joinCall(_callIdController.text.trim());
                    }
                  },
                  child: Text('Join Call'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    callProvider.endCall(_callIdController.text.trim());
                  },
                  child: Text('End Call'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Mute/Unmute Button
                ElevatedButton(
                  onPressed: () {
                    callProvider.toggleMute();
                  },
                  child: Text(callProvider.isMuted ? 'Unmute' : 'Mute'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    callProvider.switchCamera();
                  },
                  child: Text('Switch Camera'),
                ),
                // ElevatedButton(
                //   onPressed: () {
                //     if (_callIdController.text.isNotEmpty) {
                //       callProvider.joinCall(_callIdController.text.trim());
                //     }
                //   },
                //   child: Text('Join Call'),
                // ),
                // SizedBox(width: 10),
                // ElevatedButton(
                //   onPressed: () {
                //     callProvider.endCall();
                //   },
                //   child: Text('End Call'),
                // ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: Row(
                children: [
                  Flexible(
                    child: Container(
                      color: Colors.black,
                      child: RTCVideoView(callProvider.localRenderer),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      color: Colors.black,
                      child: RTCVideoView(callProvider.remoteRenderer),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
