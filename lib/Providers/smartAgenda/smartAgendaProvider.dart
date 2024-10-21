import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tabibinet_project/model/smartAgenda/smartAgendaModel.dart';

class SmartAgendaProvider with ChangeNotifier {
  List<SmartAppointment> appointments = [];
  Map<String, int> feesTypeCounts = {}; // Map to store the counts of each feesType
  Map<String, String> feesTypeTimes = {}; // Map to store the time ranges of each feesType

  bool isLoading = true;

  SmartAgendaProvider() {
    fetchAppointmentsData();
  }

  Future<void> fetchAppointmentsData() async {
    try {
      // Fetch all appointment documents
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('appointment').get();

      // Convert the fetched documents into a list of Appointment objects
      appointments = snapshot.docs.map((doc) {
        return SmartAppointment.fromFirestore(doc.data() as Map<String, dynamic>);
      }).toList();

      // Initialize the counts map
      feesTypeCounts = {};
      feesTypeTimes = {};


      // Count the occurrences of each feesType
      for (var appointment in appointments) {
        String feesType = appointment.feesType;
        String appointmentTime = appointment.appointmentTime; // Add appointment time


        if (feesTypeCounts.containsKey(feesType)) {
          feesTypeCounts[feesType] = feesTypeCounts[feesType]! + 1;
        } else {
          feesTypeCounts[feesType] = 1;
        }
        // Store the appointment time for each feesType
        // You may want to store the most recent or average time, adjust as needed
        if (!feesTypeTimes.containsKey(feesType)) {
          feesTypeTimes[feesType] = appointmentTime;  // For now, we store the first time encountered
        }
      }

    } catch (e) {
      log("Error fetching appointments: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
