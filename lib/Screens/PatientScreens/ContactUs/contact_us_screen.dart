import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:tabibinet_project/Screens/ChatScreens/chat_screen.dart';
import 'package:tabibinet_project/constant.dart';
import 'package:tabibinet_project/global_provider.dart';
import 'package:tabibinet_project/model/res/constant/app_fonts.dart';
import 'package:tabibinet_project/model/res/widgets/header.dart';
import 'package:tabibinet_project/model/res/widgets/input_field.dart';
import 'package:tabibinet_project/model/res/widgets/submit_button.dart';
import 'package:tabibinet_project/model/res/widgets/text_widget.dart';
import 'package:tabibinet_project/model/res/widgets/toast_msg.dart';

import '../../../Providers/translation/translation_provider.dart';

class ContactUsScreen extends StatelessWidget {
  ContactUsScreen({super.key});

  final nameC = TextEditingController();
  final phoneC = TextEditingController();
  final problemC = TextEditingController();

  @override
  Widget build(BuildContext context) {

    double height1 = 20;
    double height2 = 10;
    final languageP  = Provider.of<TranslationProvider>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
             Header(text: languageP.translatedTexts["Contact Us"] ?? "Contact Us"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   TextWidget(
                    text: "Full Name", fontSize: 14,
                    fontWeight: FontWeight.w600, isTextCenter: false,
                    textColor: textColor, fontFamily: AppFonts.semiBold,),
                  SizedBox(height: height2,),
                  InputField(
                    inputController: nameC,
                    hintText: "Full Name",
                  ),
                  SizedBox(height: height1,),
                  const TextWidget(
                    text: "Phone Number", fontSize: 14,
                    fontWeight: FontWeight.w600, isTextCenter: false,
                    textColor: textColor, fontFamily: AppFonts.semiBold,),
                  SizedBox(height: height2,),
                  InputField(
                    inputController: phoneC,
                    hintText: "Phone Number",
                  ),
                  SizedBox(height: height1,),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(
                        text: "Write Your Problem", fontSize: 14,
                        fontWeight: FontWeight.w600, isTextCenter: false,
                        textColor: textColor, fontFamily: AppFonts.semiBold,),
                      TextWidget(
                        text: "Max 250 words", fontSize: 12,
                        fontWeight: FontWeight.w400, isTextCenter: false,
                        textColor: textColor,),
                    ],
                  ),
                  SizedBox(height: height2,),
                  InputField(
                    inputController: problemC,
                    hintText: "Tell doctor about your problem....",
                    maxLines: 5,
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SubmitButton(
            title: "Send Massage",
            press: () async {

              final chatP = GlobalProviderAccess.chatProvider;

              final chatRoomId = await chatP!.createOrGetChatRoom(
                  "admin@tabibinet.com", ""
              );

            Get.to(ChatScreen(
                chatRoomId: chatRoomId,
                patientEmail: "admin@tabibinet.com",
                patientName: "Customer Support",
                profilePic: "https://res.cloudinary.com/dz0mfu819/image/upload/v1725947218/profile_xfxlfl.png",
              type: "support",
              deviceToken: "",
              name: nameC.text.toString(),
              phone: phoneC.text.toString(),
              problem: problemC.text.toString(),
            ));


          },),
        ),
      ),
    );
  }
}
