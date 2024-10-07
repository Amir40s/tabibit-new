class MedicineModel {
  String id; // Document ID
  String dosage;
  String duration;
  List<String> repeat;
  String tabletName;
  List<String> taken;
  List<String> timeDay;

  MedicineModel({
    required this.id,
    required this.dosage,
    required this.duration,
    required this.repeat,
    required this.tabletName,
    required this.taken,
    required this.timeDay,
  });

  // Method to create a MedicineModel from FireStore document (with document ID)
  factory MedicineModel.fromMap(Map<String, dynamic> data, String documentId) {
    return MedicineModel(
      id: documentId,  // Assigning document ID
      dosage: data['dosage'] ?? '',
      duration: data['duration'] ?? '',
      repeat: List<String>.from(data['repeat'] ?? []),
      tabletName: data['tabletName'] ?? '',
      taken: List<String>.from(data['taken'] ?? []),
      timeDay: List<String>.from(data['timeDay'] ?? []),
    );
  }

  // Method to convert the model to a map (to save it to Firestore)
  Map<String, dynamic> toMap() {
    return {
      'dosage': dosage,
      'duration': duration,
      'repeat': repeat,
      'tabletName': tabletName,
      'taken': taken,
      'timeDay': timeDay,
    };
  }
}
