import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tabibinet_project/Screens/PatientScreens/VideoCall/video_call_accept_screen.dart';
import 'package:tabibinet_project/Screens/PatientScreens/VideoCall/video_call_screen.dart';
import 'package:tabibinet_project/constant.dart';
import 'package:tabibinet_project/model/res/constant/app_fonts.dart';
import 'package:tabibinet_project/model/res/constant/app_icons.dart';
import 'package:tabibinet_project/model/res/widgets/header.dart';
import 'package:tabibinet_project/model/res/widgets/text_widget.dart';

import 'model/data/call_model.dart';
import 'model/res/widgets/no_found_card.dart';

class CallScreen extends StatelessWidget {
  const CallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
            const Header(text: "Appointment Calls"),
            Expanded(
              child: StreamBuilder<List<CallModel>>(
                stream: fetchCalls(),
                builder: (context, snapshot) {

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const NoFoundCard(
                      subTitle: "",
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var call = snapshot.data![index];
                      return ListTile(
                        onTap: () {
                          if(call.status == "Incoming"){
                            log("call id: ${call.id}");
                            Get.to(()=>VideoCallAcceptScreen(
                              callID: call.webrtcId,
                              doctorName: call.patientName,
                              doctorImage: "",
                              isVideo: call.isVideo,
                              id: call.id,
                            ));
                          }
                        },
                        title: TextWidget(
                          text: call.patientName,
                          fontSize: 14,
                          fontFamily: AppFonts.semiBold,
                          textColor: textColor,
                        ),
                        subtitle: TextWidget(
                          text: call.status,
                          fontSize: 11,
                          fontFamily: AppFonts.medium,
                          textColor: textColor,
                        ),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CircleAvatar(
                            backgroundColor: purpleColor.withOpacity(.3),
                            child: SvgPicture.asset(AppIcons.upcomingAppointmentIcon),
                          ),
                        ),
                        trailing: call.status == "Incoming" ?
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CircleAvatar(
                            backgroundColor: Colors.green,
                            child: SvgPicture.asset(call.isVideo ? AppIcons.video : AppIcons.phone),
                          ),
                        ) :
                        const SizedBox(),
                      );
                    },);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Stream<List<CallModel>> fetchCalls() {
    return fireStore.collection('calls')
        .where("doctorId", isEqualTo: auth.currentUser!.uid)
        .snapshots().map((snapshot) {
      List<CallModel> calls = snapshot.docs.map((doc) => CallModel.fromDocumentSnapshot(doc)).toList();

      // Sort calls by 'id' in descending order
      calls.sort((a, b) => b.id.compareTo(a.id));  // Assuming 'id' is a field in CallModel

      return calls;
    });
  }

}
