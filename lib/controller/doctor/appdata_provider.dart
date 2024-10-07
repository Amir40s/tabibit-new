import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:tabibinet_project/Providers/FaqProvider/faq_provider.dart';
import 'package:tabibinet_project/Providers/translation/translation_provider.dart';
import 'package:tabibinet_project/global_provider.dart';
import 'package:tabibinet_project/model/data/faq_model.dart';
import 'package:tabibinet_project/model/data/fee_information_model.dart';
import 'package:tabibinet_project/model/data/specialize_model.dart';
import 'package:tabibinet_project/Providers/FindDoctor/find_doctor_provider.dart';
import '../../model/data/user_model.dart';

class AppDataProvider extends ChangeNotifier {

  List<SpecializeModel> _specialties = [];
  bool _isLoading = true;
  List<UserModel> _doctorsList = [];
  bool _isDoctor = true;
  List<FaqModel> _faqList = [];
  bool _isFaq = true;
  List<FeeInformationModel> _feeList = [];
  bool _isFee = true;

  AppDataProvider();

  List<SpecializeModel> get specialties => _specialties;
  bool get isLoading => _isLoading;
  List<UserModel> get doctorsList => _doctorsList;
  bool get isDoctor => _isDoctor;
  List<FaqModel> get faqList => _faqList;
  bool get isFaq => _isFaq;
  List<FeeInformationModel> get feeList => _feeList;
  bool get isFee => _isFee;

  // Initialize data fetching
  void fetchAll() {
    fetchSpecialties();
    fetchDoctors();
    fetchFees();
    fetchFaq();
  }


  final findDoctorProvider = GlobalProviderAccess.findDoctorPro;

  void fetchSpecialties() async {
    _isLoading = true;
    notifyListeners();
    try {
      final data = await findDoctorProvider!.fetchSpeciality().first;
      _specialties = data;
      final languageProvider = GlobalProviderAccess.translationProvider; // Adjust the way you access the provider
      languageProvider?.setSpecialties(data.map((e) => e.specialty).toList());
    } catch (e) {
      log(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void fetchDoctors() async {
    _isDoctor = true;
    notifyListeners();
    try {
      final data = await findDoctorProvider!.fetchDoctors().first;
      _doctorsList = data;
      final languageProvider = GlobalProviderAccess.translationProvider; // Adjust the way you access the provider
      languageProvider?.setHomeDoctors(data.map((e) => e.name).toList());
    } catch (e) {
      log(e.toString());
    } finally {
      _isDoctor = false;
      notifyListeners();
    }
  }

  void fetchFees() async {
    final feesProvider = GlobalProviderAccess.patientAppointmentProvider;
    _isFee = true;
    notifyListeners();
    try {
      final data = await feesProvider!.fetchFeeInfo().first;
      _feeList = data;
      final languageProvider = GlobalProviderAccess.translationProvider; // Adjust the way you access the provider
      languageProvider?.setFeesDoctors(data.map((e) => e.type).toList());
    } catch (e) {
      log(e.toString());
    } finally {
      _isFee = false;
      notifyListeners();
    }
  }


  void fetchFaq() async {
    final faqProvider = GlobalProviderAccess.faqProvider;
    if (faqProvider == null) {
      return;
    }
    _isFaq = true;
    notifyListeners();
    try {
      final data = await faqProvider.fetchFaq().first;
      _faqList = data.cast<FaqModel>();
      final languageProvider = GlobalProviderAccess.translationProvider; // Adjust the way you access the provider
      languageProvider?.setFAQ(data.map((e) => e.question).toList());
    } catch (e) {
      log(e.toString());
    } finally {
      _isFaq = false;
      notifyListeners();
    }
  }


  void setDoctorCategory(int index, String id, String specialty) {
    findDoctorProvider!.setDoctorCategory(index, id, specialty);
  }
}
