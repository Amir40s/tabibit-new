import 'package:get/get.dart';
import 'package:tabibinet_project/model/data/notification_model.dart';

import '../Providers/PatientNotification/patient_notification_provider.dart';

class NotificationController extends GetxController {
  final PatientNotificationProvider findNotificationProvider;
  RxList<NotificationModel> notificationModel = <NotificationModel>[].obs;
  RxBool isLoading = true.obs;


  NotificationController(this.findNotificationProvider);

  @override
  void onInit() {
    fetchNotifications();
    super.onInit();
  }

  void fetchNotifications() async {
    isLoading(true);
    try {
      final data = await findNotificationProvider.fetchNotifications().first;
      notificationModel.value = data;
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch notifications");
    } finally {
      isLoading(false);
    }
  }


}
