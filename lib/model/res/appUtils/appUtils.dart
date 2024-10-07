import 'package:provider/provider.dart';
import 'package:tabibinet_project/Providers/chatProvider/chat_provider.dart';
import 'package:tabibinet_project/global_provider.dart';

class AppUtils{
  final provider = GlobalProviderAccess.profilePro;
  String? getCurrentUserEmail(){

    String email = provider!.doctorEmail;
    return email;
  }

}