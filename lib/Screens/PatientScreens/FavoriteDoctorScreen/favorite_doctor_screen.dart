import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/model/data/user_model.dart';
import 'package:tabibinet_project/model/res/widgets/no_found_card.dart';
import '../../../../constant.dart';
import '../../../../model/res/widgets/header.dart';
import '../../../../model/res/widgets/input_field.dart';
import '../../../Providers/Favorite/favorite_doctor_provider.dart';
import '../../../Providers/PatientAppointment/patient_appointment_provider.dart';
import '../../../controller/translation_controller.dart';
import '../DoctorDetailScreen/doctor_detail_screen.dart';
import '../PatientHomeScreen/components/top_doctor_container.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({Key? key}) : super(key: key);

  final TextEditingController searchC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context, listen: false);
    final appointmentScheduleP = Provider.of<PatientAppointmentProvider>(context, listen: false);

    final TranslationController translationController = Get.put(TranslationController());

    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Header(text: "My Favourite Doctor"),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 87.w,
                          height: 50,
                          child: InputField2(
                            inputController: searchC,
                            hintText: "Find here!",
                            prefixIcon: Icons.search,
                            onChanged: (value) {
                              favoritesProvider.filterDoc(value);
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Consumer<FavoritesProvider>(
                      builder: (context, value, child) {
                        return StreamBuilder<List<UserModel>>(
                          stream: value.filterValue.isEmpty
                              ? favoritesProvider.favoriteDoctorDetailsStream()
                              : favoritesProvider.fetchFilterFavDoc(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator());
                            }

                            if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return const NoFoundCard();
                            }

                            final specs = snapshot.data!;


                            if (translationController.translations.isEmpty) {
                              translationController.translateHomeDoctor(
                                specs.map((e) => e.name).toList() +
                                    specs.map((e) => e.speciality).toList() +
                                    specs.map((e) => e.specialityDetail).toList() +
                                    specs.map((e) => e.availabilityFrom).toList() +
                                    specs.map((e) => e.availabilityTo).toList() +
                                    specs.map((e) => e.appointmentFee).toList(),
                              );
                            }

                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: specs.length,
                              itemBuilder: (context, index) {
                                final doctor = specs[index];

                                final name = translationController.translations[doctor.name] ?? doctor.name;
                                final speciality = translationController.translations[doctor.speciality] ?? doctor.speciality;
                                final specialityDetail = translationController.translations[doctor.specialityDetail] ?? doctor.specialityDetail;

                                return TopDoctorContainer(
                                  doctorName: name,
                                  specialityName: speciality,
                                  specialityDetail: specialityDetail,
                                  availabilityFrom: doctor.availabilityFrom,
                                  availabilityTo: doctor.availabilityTo,
                                  appointmentFee: doctor.appointmentFee,
                                  rating: doctor.rating,
                                  imageUrl: doctor.profileUrl,
                                  isOnline: doctor.isOnline,
                                  isFav: value.isFavorite(doctor.userUid),
                                  likeTap: () {
                                    value.toggleFavorite(doctor.userUid);
                                  },
                                  onTap: () {
                                    appointmentScheduleP.setDoctorDetails(
                                      doctor.userUid,
                                      doctor.name,
                                      doctor.location,
                                      doctor.rating,
                                      doctor.email,
                                      doctor.deviceToken
                                    );
                                    appointmentScheduleP.setAvailabilityTime(
                                      doctor.availabilityFrom,
                                      doctor.availabilityTo,
                                    );
                                    Get.to(() => DoctorDetailScreen(
                                      doctorName: doctor.name,
                                      specialityName: doctor.speciality,
                                      doctorDetail: doctor.specialityDetail,
                                      yearsOfExperience: doctor.experience,
                                      patients: doctor.patients,
                                      reviews: doctor.reviews,
                                      image: doctor.profileUrl,
                                    ));
                                  },
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
