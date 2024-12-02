import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../Providers/stream/stream_data_provider.dart';
import '../../../../Providers/translation/translation_provider.dart';
import '../../../../constant.dart';
import '../../../../model/data/report_model.dart';
import '../../../../model/res/constant/app_fonts.dart';
import '../../../../model/res/constant/app_icons.dart';
import '../../../../model/res/widgets/no_found_card.dart';
import '../../../../model/res/widgets/submit_button.dart';
import '../../../../model/res/widgets/text_widget.dart';

class LapReportListWidget extends StatelessWidget {
  final String appointmentId,type;
  const LapReportListWidget({super.key, required this.appointmentId,this.type = "doctor"});

  @override
  Widget build(BuildContext context) {
    final stream = Provider.of<StreamDataProvider>(context,listen: false);
    final provider = Provider.of<TranslationProvider>(context);
    return StreamBuilder<List<ReportModel>>(
      stream: stream.fetchReport(appointmentId: appointmentId),
      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const NoFoundCard(subTitle: "",);
        }

        final reps = snapshot.data!;

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: reps.length,
          itemBuilder: (context, index) {
            final rep = reps[index];
            return Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: greyColor)
              ),
              child: Row(
                children: [
                  Image.asset(AppIcons.pdfIcon,height: 30,),
                  SizedBox(width: 1.w,),
                  TextWidget(
                    text: "PDF File", fontSize: 14.sp,
                    fontWeight: FontWeight.w600, isTextCenter: false,
                    textColor: textColor, fontFamily: AppFonts.semiBold,),
                  const Spacer(),
                  Row(
                    children: [
                      SubmitButton(
                        title: provider.translatedTexts["view"] ?? "view",
                        width: 18.w,
                        radius: 6,
                        height: 30,
                        press: () {
                          _launchURL(rep.fileUrl);
                        },),
                      SizedBox(width: 1.w,),
                      if(type != "patient")
                      SubmitButton(
                        title: provider.translatedTexts["Delete"] ?? "Delete",
                        width: 18.w,
                        radius: 6,
                        height: 30,
                        press: () {
                          fireStore.collection("appointment")
                              .doc(appointmentId)
                              .collection("report")
                              .doc(rep.id).delete();
                        },),
                    ],
                  )
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 10,),
        );
      },);
  }
  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $url';
    }
  }
}
