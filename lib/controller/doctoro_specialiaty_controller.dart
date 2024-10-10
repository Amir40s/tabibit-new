import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tabibinet_project/Providers/FaqProvider/faq_provider.dart';
import 'package:tabibinet_project/Providers/translation/translation_provider.dart';
import 'package:tabibinet_project/global_provider.dart';
import 'package:tabibinet_project/model/data/faq_model.dart';
import 'package:tabibinet_project/model/data/fee_information_model.dart';
import 'package:tabibinet_project/model/data/specialize_model.dart';
import 'package:tabibinet_project/Providers/FindDoctor/find_doctor_provider.dart';

import '../Providers/Language/language_provider.dart';
import '../model/data/user_model.dart';

class AppDataController extends GetxController {
  final FindDoctorProvider? findDoctorProvider;
  RxList<SpecializeModel> specialties = <SpecializeModel>[].obs;
  RxBool isLoading = true.obs;

  RxList<UserModel> doctorsList = <UserModel>[].obs;
  RxBool isDoctor = true.obs;

  RxList<FaqModel> faqList = <FaqModel>[].obs;
  RxBool isFaq = true.obs;

  RxList<FeeInformationModel> feeList = <FeeInformationModel>[].obs;
  RxBool isFee = true.obs;

  AppDataController([this.findDoctorProvider]);

  @override
  void onInit() {
    fetchSpecialties();
    fetchDoctors();
    fetchFees();
    fetchFaq();
    super.onInit();
  }


  void fetchAll() {
    fetchSpecialties();
    fetchDoctors();
    fetchFees();
    fetchFaq();
  }

  void fetchSpecialties() async {
    isDoctor(true);
    try {
      final data = await findDoctorProvider!.fetchSpeciality().first;
      specialties.value = data;
      final languageProvider = Get.put(TranslationProvider());
      languageProvider.setSpecialties(data.map((e) => e.specialty).toList());
      update();
    } catch (e) {
      log(e.toString());
      // Get.snackbar("Error", "Failed to fetch specialties");
    } finally {
      isLoading(false);
    }
  }

  void fetchDoctors() async {
    isDoctor(true);
    try {
      final data = await findDoctorProvider!.fetchDoctors().first;
      doctorsList.value = data;
      final languageProvider = Get.put(TranslationProvider());
      languageProvider.setHomeDoctors(data.map((e) => e.name).toList());
      update();
    } catch (e) {
      log(e.toString());
    } finally {
      isDoctor(false);
    }
  }

  void fetchFees() async {
    final feesProvider = GlobalProviderAccess.patientAppointmentProvider;
    isFee(true);
    try {
      FirebaseFirestore.instance.collection('faq').snapshots().listen((event) {
        faqList.clear();
        for (var doc in event.docs) {
          faqList.add(FaqModel.fromDocumentSnapshot(doc));
        }
        isFaq.value = false;
        update();
      });
      // final data = await feesProvider!.fetchFeeInfo().first;
      // feeList.value = data;

      // final languageProvider = Get.put(TranslationProvider());
      // languageProvider.setFeesDoctors(data.map((e) => e.type).toList());
    } catch (e) {
      log(e.toString());
    } finally {
      isFee(false);
    }
  }

  void fetchFaq() async {
    final faqProvider = GlobalProviderAccess.faqProvider;
    if (faqProvider == null) {
      Get.snackbar("Error", "FAQ provider is unavailable");
      return;
    }
    isFaq(true);
    try {
      final data = await faqProvider.fetchFaq().first;
      faqList.value = data.cast<FaqModel>();
      final languageProvider = Get.put(TranslationProvider());
      languageProvider.setFAQ(data.map((e) => e.question).toList());
      update();
    } catch (e) {
      log(e.toString());
    } finally {
      isFaq(false);
    }
  }



  void setDoctorCategory(int index, String id, String specialty) {
    findDoctorProvider!.setDoctorCategory(index, id, specialty);
  }

}
