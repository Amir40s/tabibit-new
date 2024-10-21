import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/constant.dart';
import 'package:tabibinet_project/global_provider.dart';
import 'package:tabibinet_project/model/res/widgets/text_widget.dart';
import 'package:tabibinet_project/sample_test_screen.dart';

import '../../../Providers/agora/webrtc_provider.dart';

class VideoCallScreen extends StatefulWidget {
 final String callID,doctorName,doctorImage;
 final bool isVideo;
   VideoCallScreen({super.key,
     required this.callID,
     required this.doctorName,
     required this.doctorImage, required this.isVideo
   });

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {


  final callProvider = GlobalProviderAccess.callProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(callProvider !=null){
      callProvider!.startCall(widget.callID,audioOnly: widget.isVideo);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
          child: Consumer<CallProvider>(
           builder: (context, provider, child){
             return Stack(
               children: [
                 Container(
                   width: 100.w,
                   height: 100.h,
                   color: themeColor,
                 ),

                 if(provider.isUserJoined)...[
                   if(widget.isVideo)
                   Flexible(
                     child: Container(
                       color: Colors.black,
                       child: RTCVideoView(
                           mirror: false,
                           provider.remoteRenderer),
                     ),
                   ),

                   if(widget.isVideo)
                   Positioned(
                     top: 10.w,
                       right: 5.w,
                       child: Container(
                         width: 40.w,
                     height: 60.w,
                     child:  ClipRRect(
                       borderRadius: BorderRadius.circular(5.w),
                       child: Flexible(
                         child: Container(
                           color: Colors.black,
                           child: RTCVideoView(
                               mirror: true,
                               provider.localRenderer),
                         ),
                       ),
                     ),
                   )
                   )

                 ]else...[
                   Positioned(
                       top: 10.h,
                       left: 35.w,
                       child: Column(
                         children: [
                           Container(
                             width: 30.w,
                             height: 30.w,
                             child: ClipRRect(
                               child: Image.network(widget.doctorImage),
                             ),
                           ),
                           SizedBox(height: 3.h,),
                           TextWidget(
                             text: "Dr. ${widget.doctorName}",
                             fontSize: 16.0,
                             textColor: Colors.white,
                           ),
                           SizedBox(height: 3.h,),
                           if(!provider.isUserJoined)
                             TextWidget(
                               text: "Ringing",
                               fontSize: 16.0,
                               textColor: Colors.white,
                             )
                         ],
                       )
                   ),
                 ],

                 Positioned(
                     bottom: 10.w,
                     child: Container(
                       width: 100.w,
                       child: Column(
                         children: [
                           if(provider.isUserJoined)
                           TextWidget(
                             text: "Dr. ${widget.doctorName}",
                             fontSize: 16.0,
                             textColor: Colors.white,
                           ),
                           SizedBox(height: 3.h,),
                           TextWidget(
                             text: "${provider.callDuration}",
                             fontSize: 16.0,
                             textColor: Colors.white,
                           ),
                           SizedBox(height: 3.h,),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             crossAxisAlignment: CrossAxisAlignment.center,
                             children: [
                               GestureDetector(
                                 onTap: (){
                                   provider.endCall(
                                       widget.callID,remoteEnd: true,userJoined: provider.isUserJoined);
                                 },
                                 child: Container(
                                   width: 50.0,
                                   height: 50.0,
                                   decoration: BoxDecoration(
                                     color: Colors.red,
                                     borderRadius: BorderRadius.circular(50.w),
                                   ),
                                   child: const Center(child: Icon(Icons.call_end, color: Colors.white)),
                                 ),
                               ),
                               SizedBox(width: 5.w,),
                               GestureDetector(
                                 onTap: (){
                                   provider.toggleMute();
                                 },
                                 child: Container(
                                   width: 50.0,
                                   height: 50.0,
                                   decoration: BoxDecoration(
                                     color: themeColor,
                                     borderRadius: BorderRadius.circular(50.w),
                                   ),
                                   child: Center(
                                       child:
                                       Icon(
                                           provider.isMuted ?  Icons.mic_off : Icons.mic,
                                           color: Colors.white)),
                                 ),
                               )
                             ],
                           ),
                         ],
                       ),
                     )
                 )

               ],
             );
           },
          )
      ),
    );
  }
}
