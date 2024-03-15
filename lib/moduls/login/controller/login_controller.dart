import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();


  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  RxBool passwordVisible = true.obs;

  void passwordVisibility() {
    passwordVisible.value = !passwordVisible.value;
  }






}