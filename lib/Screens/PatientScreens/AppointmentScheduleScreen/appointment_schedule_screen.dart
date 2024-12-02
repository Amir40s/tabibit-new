import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/model/data/user_model.dart';
import '../../../../Providers/Language/new/translation_new_provider.dart';
import '../../../../Providers/PatientHome/patient_home_provider.dart';
import '../../../../constant.dart';
import '../../../../model/res/widgets/header.dart';
import '../../../../model/res/widgets/submit_button.dart';
import '../../../../model/res/widgets/text_widget.dart';
import '../../../Providers/FindDoctor/find_doctor_provider.dart';
import '../../../Providers/PatientAppointment/patient_appointment_provider.dart';
import '../../../Providers/translation/translation_provider.dart';
import '../../../controller/doctoro_specialiaty_controller.dart';
import '../../../model/data/fee_information_model.dart';
import '../../../model/res/constant/app_fonts.dart';
import '../../../model/res/constant/app_icons.dart';
import '../../../model/res/widgets/dotted_border_container.dart';
import '../../../model/res/widgets/toast_msg.dart';
import '../FilterScreen/Components/calender_section.dart';
import '../FilterScreen/Components/time_section.dart';
import '../PatientDetailScreen/patient_detail_screen.dart';
import 'Components/fee_container.dart';

class AppointmentScheduleScreen extends StatelessWidget {
  const AppointmentScheduleScreen({super.key, required this.image, required this.model});

  final String image;
  final UserModel model;

  @override
  Widget build(BuildContext context) {
    final patientAppointmentP = Provider.of<PatientAppointmentProvider>(context);
    final languageP = Provider.of<TranslationProvider>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
            const Header(text: "Appointment"),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  const SizedBox(height: 20),
                  _buildScheduleHeader(context, patientAppointmentP),
                  const SizedBox(height: 20),
                  _buildCalendarSection(),
                  const SizedBox(height: 20),
                  const _SectionTitle(title: "Doctor Availability"),
                  const SizedBox(height: 20),
                  _buildTimeSection(),
                  const SizedBox(height: 20),
                  const _SectionTitle(title: "Choose Consultation Type"),
                  const SizedBox(height: 20),
                  _buildFeeInformation(context, languageP,model),
                  const SizedBox(height: 20),
                  const _SectionTitle(title: "Any Document (optional)"),
                  const SizedBox(height: 20),
                  _buildDocumentUploadSection(context),
                  const SizedBox(height: 8),
                  _buildFileTypeInfo(),
                  SizedBox(height: 8.w),
                  _buildSubmitButton(context, patientAppointmentP, languageP),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the Schedule Header with a date picker
  Widget _buildScheduleHeader(BuildContext context, PatientAppointmentProvider patientAppointmentP) {
    return Consumer<DateProvider>(
      builder: (context, dateProvider, child) {
        final currentMonth = dateProvider.selectedDate;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              const TextWidget(
                text: "Schedules",
                fontSize: 20,
                fontWeight: FontWeight.w600,
                isTextCenter: false,
                textColor: textColor,
                fontFamily: AppFonts.semiBold,
              ),
              const Spacer(),
              InkWell(
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: currentMonth,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (selectedDate != null) {
                    dateProvider.updateSelectedDate(selectedDate);
                    patientAppointmentP.setAppointmentDate(selectedDate);
                  }
                },
                child: Row(
                  children: [
                    TextWidget(
                      text: DateFormat('MMMM-yyyy').format(currentMonth),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      isTextCenter: false,
                      textColor: textColor,
                    ),
                    const SizedBox(width: 8),
                    const _CircleIcon(icon: CupertinoIcons.forward),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCalendarSection() {
    return Consumer<DateProvider>(
      builder: (context, dateProvider, child) {
        return CalendarSection(
          month: dateProvider.selectedDate,
          firstDate: DateTime.now(),
        );
      },
    );
  }

  Widget _buildTimeSection() {
    return Consumer<PatientAppointmentProvider>(
      builder: (context, value, child) {
        return TimeSection(filteredTime: value.filteredTime);
      },
    );
  }

  Widget _buildFeeInformation(
      BuildContext context,
      TranslationProvider languageP,
      UserModel model
      ) {
    final feeOptions = [
      {
        "title": "Video Consultation",
        "fee": model.appointmentFee,
        "subtitle": "Healthcare services at your home."
      },
      {
        "title": "In-Office Consultation",
        "fee": model.inOfficeFee,
        "subtitle": "Face-to-face visit at a clinic"
      },
      {
        "title": "Home Visit Consultation",
        "fee": model.homeVisitFee,
        "subtitle": "Consultation at your home"
      },
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Consumer<PatientAppointmentProvider>(
        builder: (context, feeProvider, _) {
          return Column(
            children: List.generate(feeOptions.length, (index) {
              final option = feeOptions[index];
              final isSelected = feeProvider.isSelected(index);
              return Column(
                children: [
                  FeeContainer(
                    onTap: () {
                      feeProvider.updateFee(
                        index,
                        option['title'] ?? "",
                        option['subtitle'] ?? "",
                        option['fee'] ?? "",
                      );
                    },
                    isSelected: isSelected,
                    title: option['title'] ?? "",
                    fees: option['fee'] ?? "0.0",
                    subTitle: option['subtitle'] ?? "",
                    borderColor: isSelected ? themeColor : greyColor,
                    icon: isSelected ? AppIcons.radioOnIcon : AppIcons.radioOffIcon,
                  ),
                  if (index != feeOptions.length - 1) SizedBox(height: 5.w),
                ],
              );
            }),
          );
        },
      ),
    );
  }

  // Widget _buildFeeInformation(BuildContext context, TranslationProvider languageP) {
  //   final patientAppointmentP = Provider.of<PatientAppointmentProvider>(context, listen: false);
  //
  //   return Consumer<TranslationNewProvider>(
  //     builder: (context, transP, child) {
  //       return Padding(
  //         padding:  EdgeInsets.symmetric(horizontal: 5.w),
  //         child: StreamBuilder<List<FeeInformationModel>>(
  //           stream: patientAppointmentP.fetchFeeInfo(),
  //           builder: (context, snapshot) {
  //             if (snapshot.connectionState == ConnectionState.waiting) {
  //               return const Center(child: CircularProgressIndicator());
  //             }
  //             if (snapshot.hasError) {
  //               return Center(child: Text('Error: ${snapshot.error}'));
  //             }
  //             if (!snapshot.hasData || snapshot.data!.isEmpty) {
  //               return const Center(child: Text('No Fees found'));
  //             }
  //
  //             final fees = snapshot.data!;
  //             if (transP.feeList.isEmpty) {
  //               transP.translateFees(
  //                 fees.map((e) => e.type).toList() + fees.map((e) => e.subTitle).toList(),
  //               );
  //             }
  //
  //             return Consumer<PatientAppointmentProvider>(
  //               builder: (context, provider, child) {
  //                 return ListView.separated(
  //                   shrinkWrap: true,
  //                   physics: const NeverScrollableScrollPhysics(),
  //                   itemCount: fees.length,
  //                   itemBuilder: (context, index) {
  //                     final isSelected = provider.selectFeeIndex == index;
  //                     final fee = fees[index];
  //                     return FeeContainer(
  //                       onTap: () => provider.setSelectedFee(index, fee.type, fee.fees, fee.id, fee.subTitle),
  //                       isSelected: isSelected,
  //                       title: transP.feeList[fee.type] ?? fee.type,
  //                       fees: fee.fees,
  //                       subTitle: transP.feeList[fee.subTitle] ?? fee.subTitle,
  //                       borderColor: isSelected ? themeColor : greyColor,
  //                       icon: isSelected ? AppIcons.radioOnIcon : AppIcons.radioOffIcon,
  //                     );
  //                   },
  //                   separatorBuilder: (_, __) => const SizedBox(height: 20),
  //                 );
  //               },
  //             );
  //           },
  //         ),
  //       );
  //     },
  //   );
  // }

  Widget _buildDocumentUploadSection(BuildContext context) {
    return Consumer<PatientAppointmentProvider>(
      builder: (context, value, child) {
        return Padding(
          padding:  EdgeInsets.symmetric(horizontal: 5.w),
          child: InkWell(
            onTap: value.pickFile,
            child: DottedBorderContainer(
              width: 100.w,
              height: 8.h,
              borderColor: greyColor,
              strokeWidth: 1.5,
              dashWidth: 10,
              borderRadius: 15,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  const Icon(Icons.attach_file_outlined, color: themeColor),
                  SizedBox(
                    width: value.selectedFilePath != null ? 60.w : 19.w,
                    child: TextWidget(
                      text: value.selectedFilePath ?? "Add a file",
                      maxLines: 1,
                      fontFamily: AppFonts.medium,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      isTextCenter: false,
                      textColor: themeColor,
                    ),
                  ),
                  if (value.selectedFilePath == null)
                    TextWidget(
                      text: "or drop it here",
                      fontFamily: AppFonts.medium,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      isTextCenter: false,
                      textColor: textColor,
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFileTypeInfo() {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 5.w),
      child: TextWidget(
        text: "File should be pdf, docs or ppt",
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        isTextCenter: false,
        textColor: textColor,
        fontFamily: AppFonts.regular,
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context, PatientAppointmentProvider patientAppointmentP, TranslationProvider languageP) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.w),
      child: SubmitButton(
        title: "Continue",
        press: () {
          if (patientAppointmentP.appointmentTime != null) {
            if (patientAppointmentP.appointmentDate == null) {
              patientAppointmentP.setAppointmentDate(DateTime.now());
            }

            if (patientAppointmentP.selectedFee.isNotEmpty) {
              Get.to(() => PatientDetailScreen(image: image));
            } else {
              ToastMsg().toastMsg(languageP.translatedTexts["Select Fee Information"] ?? "Select Fee Information", toastColor: redColor);
            }
          } else {
            ToastMsg().toastMsg(languageP.translatedTexts["Select Appointment Time!"] ?? "Select Appointment Time!", toastColor: redColor);
          }
        },
      ),
    );
  }
}

class _CircleIcon extends StatelessWidget {
  const _CircleIcon({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 12,
      backgroundColor: greyColor,
      child: Icon(icon, color: textColor, size: 16),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextWidget(
        text: title,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        isTextCenter: false,
        textColor: textColor,
        fontFamily: AppFonts.semiBold,
      ),
    );
  }
}
