import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tabibinet_project/Providers/FindDoctor/find_doctor_provider.dart';
import 'package:tabibinet_project/Providers/Language/new/translation_new_provider.dart';
import 'package:tabibinet_project/controller/doctor/appdata_provider.dart';
import 'package:tabibinet_project/model/res/widgets/no_found_card.dart';

import '../../../../Providers/Favorite/favorite_doctor_provider.dart';
import '../../../../Providers/PatientAppointment/patient_appointment_provider.dart';
import '../../../../Providers/PatientHome/patient_home_provider.dart';
import '../../../../controller/doctoro_specialiaty_controller.dart';
import '../../../../controller/translation_controller.dart';
import '../../../../model/data/user_model.dart';
import '../../DoctorDetailScreen/doctor_detail_screen.dart';
import 'top_doctor_container.dart';

class DoctorSection extends StatelessWidget {
  const DoctorSection({super.key});

  @override
  Widget build(BuildContext context) {
    final appointmentScheduleP = Provider.of<PatientAppointmentProvider>(context, listen: false);

    final docp = Provider.of<FindDoctorProvider>(context,listen: false);

    return Consumer<TranslationNewProvider>(
     builder: (context,provider,child){
       return StreamBuilder<List<UserModel>>(
           stream: docp.fetchDoctors(), // Assume this is the stream of specialties
           builder: (context, snapshot) {
             if (snapshot.connectionState == ConnectionState.waiting) {
               return const Center(child: CircularProgressIndicator());
             }

             if (!snapshot.hasData || snapshot.data!.isEmpty) {
               return const Center(child: Text('No Doctors found'));
             }

             final specs = snapshot.data!;

             log("List:: $specs");

             if (provider.translations.isEmpty) {
               provider.translateHomeDoctor(
                 specs.map((e) => e.name).toList() +
                     specs.map((e) => e.speciality).toList() +
                     specs.map((e) => e.specialityDetail).toList() +
                     specs.map((e) => e.availabilityFrom).toList() +
                     specs.map((e) => e.availabilityTo).toList() +
                     specs.map((e) => e.appointmentFee).toList(),
               );
             }

             return ListView.builder(
               padding: const EdgeInsets.symmetric(horizontal: 20),
               shrinkWrap: true,
               physics: const NeverScrollableScrollPhysics(),
               itemCount: specs.length,
               itemBuilder: (context, index) {
                 final doc = specs[index];
                 final name = provider.translations[doc.name] ?? doc.name;
                 final speciality = provider.translations[doc.speciality] ?? doc.speciality;
                 final specialityDetail = provider.translations[doc.specialityDetail] ?? doc.specialityDetail;
                 log("Translated speciality: $speciality");

                 log("message:: $speciality");
                 return Consumer<FavoritesProvider>(
                   builder: (context, provider,value){
                     return TopDoctorContainer(
                       doctorName: name,
                       specialityName: speciality,
                       specialityDetail: specialityDetail,
                       availabilityFrom: doc.availabilityFrom,
                       availabilityTo: doc.availabilityTo,
                       appointmentFee: doc.appointmentFee,
                       imageUrl: doc.profileUrl,
                       rating: doc.rating,
                       isOnline: doc.isOnline,
                       isFav: provider.isFavorite(doc.userUid),
                       likeTap: () {
                         provider.toggleFavorite(doc.userUid);
                       },
                       onTap: () async{
                         appointmentScheduleP.setDoctorDetails(
                             doc.userUid,
                             doc.name,
                             doc.location,
                             doc.rating,
                             doc.email,
                             doc.deviceToken
                         );
                         log("Doctor Name: ${doc.name}");
                         appointmentScheduleP.setAvailabilityTime(
                             doc.availabilityFrom,
                             doc.availabilityTo
                         );
                         log("Avability:: ${doc.availabilityFrom} : ${doc.availabilityTo}" );
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
               },
             );
           });
     },
    );


    // return Consumer(
    //   builder: (context, value, child) {
    //     return StreamBuilder<List<UserModel>>(
    //       stream: docp.fetchDoctors(),
    //       builder: (context, snapshot) {
    //         if (snapshot.connectionState == ConnectionState.waiting) {
    //           return const Center(child: CircularProgressIndicator());
    //         }
    //         if (snapshot.hasError) {
    //           return Center(child: Text('Error: ${snapshot.error}'));
    //         }
    //         if (!snapshot.hasData || snapshot.data!.isEmpty) {
    //           return const NoFoundCard();
    //         }
    //
    //         final docs = snapshot.data!;
    //
    //         return Consumer<FavoritesProvider>(
    //           builder: (context, provider, child) {
    //
    //
    //
    //
    //
    //             return ListView.builder(
    //               padding: const EdgeInsets.symmetric(horizontal: 20),
    //               shrinkWrap: true,
    //               physics: const NeverScrollableScrollPhysics(),
    //               itemCount: docs.length,
    //               itemBuilder: (context, index) {
    //                 final doc = docs[index];
    //                 return TopDoctorContainer(
    //                   doctorName: doc.name,
    //                   specialityName: doc.speciality,
    //                   specialityDetail: doc.specialityDetail,
    //                   availabilityFrom: doc.availabilityFrom,
    //                   availabilityTo: doc.availabilityTo,
    //                   appointmentFee: doc.appointmentFee,
    //                   imageUrl: doc.profileUrl,
    //                   rating: doc.rating,
    //                   isOnline: doc.isOnline,
    //                   isFav: provider.isFavorite(doc.userUid),
    //                   likeTap: () {
    //                     provider.toggleFavorite(doc.userUid);
    //                   },
    //                   onTap: () {
    //                     appointmentScheduleP.setDoctorDetails(
    //                         doc.userUid,
    //                         doc.name,
    //                         doc.location,
    //                         doc.rating,
    //                         doc.email
    //                     );
    //                     appointmentScheduleP.setAvailabilityTime(
    //                         doc.availabilityFrom,
    //                         doc.availabilityTo
    //                     );
    //                     Get.to(()=> DoctorDetailScreen(
    //                       doctorName: doc.name,
    //                       specialityName: doc.speciality,
    //                       doctorDetail: doc.specialityDetail,
    //                       yearsOfExperience: doc.experience,
    //                       patients: doc.patients,
    //                       reviews: doc.reviews,
    //                       image: doc.profileUrl,
    //                     ));
    //                   },
    //                 );
    //               },
    //             );
    //         },);
    //       },
    //     );
    // },);
  }
}
