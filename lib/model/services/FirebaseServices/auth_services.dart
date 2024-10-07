import 'dart:developer';
import 'package:tabibinet_project/constant.dart';

class AuthServices{

  Future<void> signUp(String email, String password) async {
    auth.createUserWithEmailAndPassword(email: email, password: password).
    then((value) {

    },).
    onError((error, stackTrace) {
      log(error.toString());
    },);
  }
}