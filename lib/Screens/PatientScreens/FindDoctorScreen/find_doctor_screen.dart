import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/Providers/Favorite/favorite_doctor_provider.dart';
import 'package:tabibinet_project/Providers/FindDoctor/find_doctor_provider.dart';
import 'package:tabibinet_project/model/res/constant/app_fonts.dart';
import 'package:tabibinet_project/Providers/PatientHome/patient_home_provider.dart';

import '../../../../constant.dart';
import '../../../../model/res/widgets/header.dart';
import '../../../../model/res/widgets/input_field.dart';
import '../../../../model/res/widgets/text_widget.dart';
import '../../../Providers/PatientAppointment/patient_appointment_provider.dart';
import '../../../model/data/specialize_model.dart';
import '../../../model/data/user_model.dart';
import '../../../model/res/constant/app_icons.dart';
import '../../../model/res/widgets/no_found_card.dart';
import '../DoctorDetailScreen/doctor_detail_screen.dart';
import '../FilterScreen/filter_screen.dart';
import '../PatientHomeScreen/components/top_doctor_container.dart';
import 'Components/suggestion_container.dart';

class FindDoctorScreen extends StatelessWidget {
  FindDoctorScreen({super.key});

  final searchC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appointmentScheduleP = Provider.of<PatientAppointmentProvider>(context, listen: false);
    final findDoctorP = Provider.of<FindDoctorProvider>(context, listen: false);
    findDoctorP.setNumberOfDoctors();
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Header(text: "Top Doctor"),
            Expanded(
                child: ListView(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: 87.w,
                              height: 50,
                              child: InputField2(
                                onChanged: (value) {
                                  findDoctorP.filterDoctor(value);
                                },
                                inputController: searchC,
                                hintText: "Find here!",
                                prefixIcon: Icons.search,
                                  suffixIcon: Container(
                                    margin: const EdgeInsets.all(14),
                                    padding: const EdgeInsets.all(3),
                                    height: 20,
                                    width: 20,
                                    decoration: const BoxDecoration(
                                      color: greenColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: SvgPicture.asset(AppIcons.crossIcon),
                                  ),
                              )),
                          // InkWell(
                          //   onTap: () {
                          //     Get.to(()=>FilterScreen());
                          //   },
                          //   child: Container(
                          //     padding: const EdgeInsets.all(15),
                          //     height: 50,
                          //     width: 50,
                          //     decoration: BoxDecoration(
                          //         color: themeColor,
                          //         borderRadius: BorderRadius.circular(10)
                          //     ),
                          //     child: SvgPicture.asset(AppIcons.menuIcon),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20,),
                    SizedBox(
                      height: 40,
                      width: 100.w,
                      child: StreamBuilder<List<SpecializeModel>>(
                        stream: findDoctorP.fetchSpeciality(),
                        builder: (context, snapshot) {

                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.hasError) {
                            return Center(child: Text('Error: ${snapshot.error}'));
                          }
                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return const Center(child: Text('No specialities found'));
                          }

                          // List of users
                          final specs = snapshot.data!;

                          return Consumer<FindDoctorProvider>(
                            builder: (context, provider, child) {
                              return ListView.builder(
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(left: 20),
                                scrollDirection: Axis.horizontal,
                                itemCount: specs.length,
                                itemBuilder: (context, index) {
                                  final spec = specs[index];
                                  final isSelected = provider.selectedIndex == index;
                                  return GestureDetector(
                                    onTap: () {
                                      provider.setDoctorCategory(index,spec.id,spec.specialty);
                                    },
                                    child: SuggestionContainer(
                                        text: spec.specialty,
                                        boxColor: isSelected ? themeColor : bgColor,
                                        textColor: isSelected ? bgColor : themeColor),
                                  );
                                },);
                            },);
                        },
                      )
                    ),
                    const SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          Consumer<FindDoctorProvider>(
                            builder: (context, value, child) {
                              return TextWidget(
                                text: "${value.numberOfDoctors} Founds", fontSize: 20,
                                fontWeight: FontWeight.w600, isTextCenter: false,
                                textColor: textColor, fontFamily: AppFonts.semiBold,);
                            },),
                          const Spacer(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Consumer<FindDoctorProvider>(
                      builder: (context, findProvider, child) {
                        return StreamBuilder<List<UserModel>>(

                          stream: findProvider.selectDoctorCategory == "All" ?
                          findDoctorP.fetchDoctors() :
                          findDoctorP.fetchSelectedCatDoc(findProvider.selectDoctorId!),

                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator());
                            }
                            if (snapshot.hasError) {
                              return Center(child: Text('Error: ${snapshot.error}'));
                            }
                            if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return const NoFoundCard();
                            }
                            // List of users
                            final docs = snapshot.data!;

                            return Consumer<FavoritesProvider>(
                              builder: (context, favProvider, child) {
                                return ListView.builder(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: docs.length,
                                  itemBuilder: (context, index) {
                                    final doc = docs[index];
                                    // final doctorId = user.userUid;
                                    return TopDoctorContainer(
                                      doctorName: doc.name,
                                      specialityName: doc.speciality,
                                      specialityDetail: doc.specialityDetail,
                                      availabilityFrom: doc.availabilityFrom,
                                      availabilityTo: doc.availabilityTo,
                                      appointmentFee: doc.appointmentFee,
                                      imageUrl: doc.profileUrl,
                                      rating: doc.rating,
                                      isOnline: doc.isOnline,
                                      isFav: favProvider.isFavorite(doc.userUid),
                                      likeTap: () {
                                        favProvider.toggleFavorite(doc.userUid);
                                      },
                                      onTap: () {
                                        appointmentScheduleP.setAvailabilityTime(
                                            doc.availabilityFrom,
                                            doc.availabilityTo
                                        );
                                        Get.to(()=> DoctorDetailScreen(
                                          doctorName: doc.name,
                                          specialityName: doc.speciality,
                                          doctorDetail: doc.specialityDetail,
                                          yearsOfExperience: doc.experience,
                                          patients: doc.patients,
                                          reviews: doc.reviews,
                                          image: doc.profileUrl,
                                        ));
                                      },
                                    );
                                  },
                                );
                            },);
                          },
                        );
                    },)
                    
                  ],
            ))
          ],
        ),
      ),
    );
  }
}
