class PrescriptionModel {
  final String tabletName;
  final String dosage;
  final String duration;
  final List<String> repeat;
  final List<String> timeDay;
  final List<String> taken;
  final String id;

  PrescriptionModel({
    required this.id,
    required this.tabletName,
    required this.dosage,
    required this.duration,
    required this.repeat,
    required this.timeDay,
    required this.taken,
  });

  // Factory constructor to create a Prescription from Firestore data
  factory PrescriptionModel.fromFirestore(Map<String, dynamic> data, String id) {
    return PrescriptionModel(
      id: id,
      tabletName: data['tabletName'] ?? '',
      dosage: data['dosage'] ?? '',
      duration: data['duration'] ?? '',
      repeat: List<String>.from(data['repeat'] ?? []),
      timeDay: List<String>.from(data['timeDay'] ?? []),
      taken: List<String>.from(data['taken'] ?? []),
    );
  }

  // Convert the Prescription object into a Firestore-friendly map
  Map<String, dynamic> toMap() {
    return {
      'tabletName': tabletName,
      'dosage': dosage,
      'duration': duration,
      'repeat': repeat,
      'timeDay': timeDay,
      'taken': taken,
    };
  }
}
