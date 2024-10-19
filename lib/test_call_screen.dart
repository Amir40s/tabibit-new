// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import 'Providers/agora/agora_provider.dart';
//
// class VideoCallScreen extends StatelessWidget {
//   final String channelName;
//   final int userId;
//
//   VideoCallScreen({required this.channelName, required this.userId});
//
//   @override
//   Widget build(BuildContext context) {
//     final agoraProvider = Provider.of<AgoraProvider>(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Agora Video Call'),
//       ),
//       body: Column(
//         children: [
//           // Local preview widget
//           Expanded(child: agoraProvider.renderLocalPreview()),
//
//           // Remote video widget
//           Expanded(child: agoraProvider.renderRemoteVideo()),
//
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   // Join the channel with a specified user ID
//                   agoraProvider.joinChannel(channelName, userId);
//                 },
//                 child: Text('Join Channel'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   agoraProvider.leaveChannel();
//                 },
//                 child: Text('Leave Channel'),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
