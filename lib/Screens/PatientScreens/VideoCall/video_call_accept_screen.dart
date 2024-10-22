import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/constant.dart';
import 'package:tabibinet_project/global_provider.dart';
import 'package:tabibinet_project/model/puahNotification/push_notification.dart';
import 'package:tabibinet_project/model/res/widgets/text_widget.dart';
import 'package:tabibinet_project/sample_test_screen.dart';

import '../../../Providers/agora/webrtc_provider.dart';

class VideoCallAcceptScreen extends StatefulWidget {
 final String callID,doctorName,doctorImage,id,patientToken;
 final bool isVideo;
 const VideoCallAcceptScreen({super.key,
     required this.callID,
     required this.doctorName,
     required this.doctorImage, required this.isVideo, required this.id, required this.patientToken,
   });

  @override
  State<VideoCallAcceptScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallAcceptScreen> {


  final callProvider = GlobalProviderAccess.callProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(callProvider !=null){
      log("Is Video: ${widget.isVideo}");
      callProvider!.joinCall(widget.callID,audioOnly: !widget.isVideo);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
          child: Consumer<CallProvider>(
            builder: (context,provider, child){
              return Stack(
                children: [
                  if(widget.isVideo)
                  Container(
                    color: Colors.black,
                    child: RTCVideoView(provider.remoteRenderer),
                  ),
                  if(widget.isVideo)
                  Positioned(
                      top: 10.w,
                      right: 5.w,
                      child: SizedBox(
                        width: 40.w,
                        height: 60.w,
                        child:  ClipRRect(
                          borderRadius: BorderRadius.circular(5.w),
                          child: Container(
                            color: Colors.black,
                            child: RTCVideoView(
                                mirror: true,
                                provider.localRenderer),
                          ),
                        ),
                      )
                  ),

                  if(!widget.isVideo)
                  Container(
                    width: 100.w,
                    height: 100.h,
                    color: themeColor,
                  ),

                  Positioned(
                      bottom: 10.w,
                      child: SizedBox(
                        width: 100.w,
                        child: Column(
                          children: [
                            TextWidget(
                              text: widget.doctorName,
                              fontSize: 16.0,
                              textColor: Colors.white,
                            ),
                            SizedBox(height: 3.h,),
                            TextWidget(
                              text: provider.callDuration,
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
                                    final fcm = FCMService();
                                    fcm.sendNotification(
                                        widget.patientToken,
                                        "Dr. ${widget.doctorName} has ended your call",
                                        "Your ${widget.isVideo ? "Video" : "Audio"} call are ended",
                                        auth.currentUser?.uid.toString() ?? ""
                                    );
                                    provider.endCall(
                                        widget.callID,
                                        remoteEnd: true,
                                        type: "doctor",
                                      id: widget.id,
                                      userJoined: provider.isUserJoined
                                    );
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
