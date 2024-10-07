import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../Providers/Favorite/favorite_doctor_provider.dart';
import '../../../Providers/FindDoctor/find_doctor_provider.dart';
import '../../../Providers/PatientAppointment/patient_appointment_provider.dart';
import '../../../constant.dart';
import '../../../model/data/user_model.dart';
import '../../../model/res/widgets/header.dart';
import '../../../model/res/widgets/no_found_card.dart';
import '../DoctorDetailScreen/doctor_detail_screen.dart';
import '../PatientHomeScreen/components/top_doctor_container.dart';

class SpecificDoctorScreen extends StatelessWidget {
  const SpecificDoctorScreen({super.key,required this.specialityName});

  final String specialityName;

  @override
  Widget build(BuildContext context) {
    final appointmentScheduleP = Provider.of<PatientAppointmentProvider>(context, listen: false);
    final findDoctorP = Provider.of<FindDoctorProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
            Header(text: specialityName),
            Expanded(
                child: Consumer<FindDoctorProvider>(
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
            )
          ],
        ),
      ),
    );
  }
}
