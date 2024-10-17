import 'dart:convert';
import 'dart:developer';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:tabibinet_project/model/api_services/url/baseurl.dart';

class AgoraProvider with ChangeNotifier {
  late RtcEngine _engine;
  List<int> remoteUsers = [];
  bool isInChannel = false;
  int? remoteUser;

  static const String appId = BaseUrl.AGORA_APPID;  // Add your Agora App ID
  static const String appCertificate = BaseUrl.AGORA_APP_CERTIFICATE;  // Add your Agora App Certificate

  AgoraProvider() {
    initializeAgora();
  }

  void initializeAgora() async {
    _engine = createAgoraRtcEngine();
    await _engine.initialize(RtcEngineContext(appId: appId));

    await _engine.enableVideo();

    // Register event handlers
    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (connection, elapsed) {
          log('Successfully joined channel: ${connection.channelId}');
          isInChannel = true;
          notifyListeners();
        },
        onUserJoined: (connection, remoteUid, elapsed) {
          log('User joined: $remoteUid');
          remoteUsers.add(remoteUid);
          remoteUser = remoteUid;
          notifyListeners();
        },
        onUserOffline: (connection, remoteUid, reason) {
          log('User offline: $remoteUid');
          remoteUsers.remove(remoteUid);
          notifyListeners();
        },
        onLeaveChannel: (connection, stats) {
          log('Left channel');
          isInChannel = false;
          remoteUsers.clear();
          notifyListeners();
        },
      ),
    );
  }

  void joinChannel(String channelName, int uid) async {
    String token = generateToken(channelName, uid);

    await _engine.joinChannel(
      token: token,
      channelId: channelName,
      uid: uid,
      options: ChannelMediaOptions(),
    );
  }

  void leaveChannel() async {
    await _engine.leaveChannel();
    isInChannel = false;
    remoteUsers = [];
    notifyListeners();
  }

  Widget renderLocalPreview() {
    if (isInChannel) {
      return AgoraVideoView(
        controller: VideoViewController(
          rtcEngine: _engine,
          canvas: const VideoCanvas(uid: 0),
        ),
      );
    } else {
      return const Center(child: Text('Joining channel...'));
    }
  }

  Widget renderRemoteVideo() {
    if (remoteUser != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: _engine,
          canvas: VideoCanvas(uid: remoteUser!),
          connection: const RtcConnection(channelId: "testChannel"),
        ),
      );
    } else {
      return const Center(child: Text('Waiting for remote user to join...'));
    }
  }

  @override
  void dispose() {
    _engine.release();
    super.dispose();
  }

  static String generateToken(String channelName, int uid) {
    int timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    int expirationTimeInSeconds = 3600;
    int privilegeExpiredTs = timestamp + expirationTimeInSeconds;

    String account = uid.toString();
    String joinTimestamp = privilegeExpiredTs.toString();

    String sign = _generateSign(account, channelName, joinTimestamp);
    return sign;
  }

  static String _generateSign(String account, String channelName, String joinTimestamp) {
    var key = utf8.encode(appCertificate);
    var message = utf8.encode('$appId$channelName$account$joinTimestamp');

    log("Message: $message");
    Hmac hmacSha256 = Hmac(sha256, key);
    Digest digest = hmacSha256.convert(message);
    return digest.toString();
  }
}
