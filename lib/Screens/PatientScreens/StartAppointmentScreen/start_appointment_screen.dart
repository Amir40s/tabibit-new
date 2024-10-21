import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/Providers/PatientAppointment/patient_appointment_provider.dart';
import 'package:tabibinet_project/Providers/Profile/profile_provider.dart';
import 'package:tabibinet_project/Screens/PatientScreens/VideoCall/video_call_screen.dart';
import 'package:tabibinet_project/global_provider.dart';
import 'package:tabibinet_project/model/puahNotification/push_notification.dart';
import 'package:tabibinet_project/model/res/appUtils/appUtils.dart';

import '../../../Providers/agora/webrtc_provider.dart';
import '../../../constant.dart';
import '../../../model/data/appointment_model.dart';
import '../../../model/res/constant/app_fonts.dart';
import '../../../model/res/constant/app_icons.dart';
import '../../../model/res/constant/app_utils.dart';
import '../../../model/res/widgets/header.dart';
import '../../../model/res/widgets/submit_button.dart';
import '../../../model/res/widgets/text_widget.dart';
import '../AppointmentScheduleScreen/Components/fee_container.dart';

class StartAppointmentScreen extends StatelessWidget {
  StartAppointmentScreen({
    super.key,
    required this.doctorName,
    required this.doctorImage,
    required this.doctorId,
    required this.doctorDeviceToken,
    required this.appointmentTime,
    required this.consultancyType,
    required this.consultancyFee,
    required this.consultancySubTitle,
    required this.model,
  });

  final String doctorName;
  final String doctorImage;
  final String doctorId;
  final String doctorDeviceToken;
  final String appointmentTime;
  final String consultancyType;
  final String consultancyFee;
  final String consultancySubTitle;
  final AppointmentModel model;

  final timeC = TextEditingController();

  final List<String> _dropdownItems = ['Consultancy', 'Video Call', 'Help Center '];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfileProvider>(context);
    final callProvider = Provider.of<CallProvider>(context);
    double height1 = 20;
    double height2 = 10;

    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
            const Header(text: "Start Appointment"),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                children: [
                  SizedBox(height: height1,),
                  Center(
                      child: SvgPicture.asset(AppIcons.notificationIcon)
                  ),
                  SizedBox(height: height1,),
                  TextWidget(
                    text: "You have received an Appointment Invitation From DR $doctorName",
                    fontSize: 20,
                    fontWeight: FontWeight.w600, isTextCenter: true, maxLines: 2,
                    textColor: textColor, fontFamily: AppFonts.semiBold,),
                  const SizedBox(height: 40,),
                  const TextWidget(
                    text: "Appointment Information", fontSize: 20,
                    fontWeight: FontWeight.w600, isTextCenter: false,
                    textColor: textColor, fontFamily: AppFonts.semiBold,),
                  SizedBox(height: height1,),
                  const TextWidget(
                    text: "Appointment Time", fontSize: 14,
                    fontWeight: FontWeight.w600, isTextCenter: false,
                    textColor: textColor, fontFamily: AppFonts.semiBold,),
                  SizedBox(height: height2,),
                  Container(
                    width: 100.w,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: themeColor
                      )
                    ),
                    child: TextWidget(
                      text: appointmentTime, fontSize: 16,
                      fontWeight: FontWeight.w600, isTextCenter: false,
                      textColor: textColor, fontFamily: AppFonts.semiBold,),
                  ),
                  SizedBox(height: height1,),
                  const TextWidget(
                    text: "Consultation Type", fontSize: 14,
                    fontWeight: FontWeight.w600, isTextCenter: false,
                    textColor: textColor, fontFamily: AppFonts.semiBold,),
                  SizedBox(height: height2,),
                  Container(
                    width: 100.w,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            color: themeColor
                        )
                    ),
                    child: TextWidget(
                      text: consultancyType, fontSize: 16,
                      fontWeight: FontWeight.w600, isTextCenter: false,
                      textColor: textColor, fontFamily: AppFonts.semiBold,),
                  ),
                  SizedBox(height: height1,),
                  FeeContainer(
                    title: consultancyType,
                    subTitle: consultancySubTitle,
                    fees: consultancyFee,
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SubmitButton(
            title: "Continue",
            press: () async {
              // final String callID = DateTime.now().millisecondsSinceEpoch.toString();
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    backgroundColor: bgColor,
                    surfaceTintColor: bgColor,
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const TextWidget(
                            text: "Select the Call Type",
                            fontSize: 14,
                            fontFamily: AppFonts.semiBold,
                          ),
                          const SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SubmitButton(
                                width: 30.w,
                                title: "Audio",
                                press: () async {
                                  await storeCallId(
                                      context,
                                      doctorId,
                                      provider.name,
                                      false,
                                      doctorDeviceToken,
                                      provider.name,
                                      "Incoming Audio Call",
                                      "xyz",
                                    doctorName,
                                    model
                                  );
                                },),
                              SubmitButton(
                                width: 30.w,
                                title: "Video",
                                press: () async {
                                   storeCallId(
                                      context,
                                      doctorId,
                                      provider.name,
                                      true,
                                      doctorDeviceToken,
                                      provider.name,
                                      "Incoming Video Call",
                                      "xyz",
                                       doctorName,
                                     model
                                  );
                                },),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },);
            },),
        ),
      ),
    );
  }

  Future<void> storeCallId(
      context,doctorId,patientName,isVideo,token,title,body,senderId,
      docName,model
      )async{
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    String callID = AppUtils().generateUniqueNumber().toString();


    final callData = GlobalProviderAccess.callDataProvider;

    callData!.setAppointments(model,isVideo);

    await fireStore.collection("calls").doc(id).set({
      "id": id,
      "callId": id,
      "patientId": auth.currentUser!.uid,
      "patientName": patientName,
      "doctorId": doctorId,
      "doctorName": model.doctorName,
      "doctorImage": model.doctorImage,
      "isVideo": isVideo,
      "status": "Incoming",
      "appointmentId" : model.id,
      "webrtcId": callID,
    });
    // final String callID = DateTime.now().millisecondsSinceEpoch.toString();
    final fcm = FCMService();
    fcm.sendNotification(token, title, body, senderId);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoCallScreen(
          callID: callID,
          doctorName: doctorName,
          doctorImage: doctorImage,
          isVideo: isVideo,
        ),
      ),
    );
  }

}
