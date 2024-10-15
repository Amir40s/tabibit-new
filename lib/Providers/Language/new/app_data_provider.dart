import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tabibinet_project/Providers/FaqProvider/faq_provider.dart';
import 'package:tabibinet_project/Providers/translation/translation_provider.dart';
import 'package:tabibinet_project/global_provider.dart';
import 'package:tabibinet_project/model/data/faq_model.dart';
import 'package:tabibinet_project/model/data/fee_information_model.dart';
import 'package:tabibinet_project/model/data/specialize_model.dart';
import 'package:tabibinet_project/Providers/FindDoctor/find_doctor_provider.dart';

import '../../../model/data/user_model.dart';

class AppDataProvider with ChangeNotifier {
  final FindDoctorProvider? findDoctorProvider;
  List<SpecializeModel> _specialties = [];
  bool _isLoading = true;

  List<UserModel> _doctorsList = [];
  bool _isDoctor = true;

  List<FaqModel> _faqList = [];
  bool _isFaq = true;

  List<FeeInformationModel> _feeList = [];
  bool _isFee = true;

  AppDataProvider([this.findDoctorProvider]) {
    fetchSpecialties();
    fetchDoctors();
    fetchFees();
    fetchFaq();
  }

  // Getters for private variables
  List<SpecializeModel> get specialties => _specialties;
  bool get isLoading => _isLoading;

  List<UserModel> get doctorsList => _doctorsList;
  bool get isDoctor => _isDoctor;

  List<FaqModel> get faqList => _faqList;
  bool get isFaq => _isFaq;

  List<FeeInformationModel> get feeList => _feeList;
  bool get isFee => _isFee;

  // Method to fetch all data
  void fetchAll() {
    fetchSpecialties();
    fetchDoctors();
    fetchFees();
    fetchFaq();
  }

  // Fetch specialties
  Future<void> fetchSpecialties() async {
    _isDoctor = true;
    notifyListeners(); // Notifies the UI to update
    try {
      final data = await findDoctorProvider!.fetchSpeciality().first;
      _specialties = data;
      final translationProvider = TranslationProvider();
      translationProvider.setSpecialties(data.map((e) => e.specialty).toList());
    } catch (e) {
      log(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Fetch doctors
  Future<void> fetchDoctors() async {
    _isDoctor = true;
    notifyListeners();
    try {
      final data = await findDoctorProvider!.fetchDoctors().first;
      _doctorsList = data;
      final translationProvider = TranslationProvider();
      translationProvider.setHomeDoctors(data.map((e) => e.name).toList());
    } catch (e) {
      log(e.toString());
    } finally {
      _isDoctor = false;
      notifyListeners();
    }
  }

  // Fetch fees
  Future<void> fetchFees() async {
    _isFee = true;
    notifyListeners();
    try {
      FirebaseFirestore.instance.collection('faq').snapshots().listen((event) {
        _faqList.clear();
        for (var doc in event.docs) {
          _faqList.add(FaqModel.fromDocumentSnapshot(doc));
        }
        _isFaq = false;
        notifyListeners();
      });
    } catch (e) {
      log(e.toString());
    } finally {
      _isFee = false;
      notifyListeners();
    }
  }

  // Fetch FAQ
  Future<void> fetchFaq() async {
    final faqProvider = GlobalProviderAccess.faqProvider;
    if (faqProvider == null) {
      // Handle error
      return;
    }
    _isFaq = true;
    notifyListeners();
    try {
      final data = await faqProvider.fetchFaq().first;
      _faqList = data.cast<FaqModel>();
      final translationProvider = TranslationProvider();
      translationProvider.setFAQ(data.map((e) => e.question).toList());
    } catch (e) {
      log(e.toString());
    } finally {
      _isFaq = false;
      notifyListeners();
    }
  }

  // Set doctor category
  void setDoctorCategory(int index, String id, String specialty) {
    findDoctorProvider!.setDoctorCategory(index, id, specialty);
    notifyListeners();
  }
}
