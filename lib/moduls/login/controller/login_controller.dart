import 'package:chatapp/api/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController otpController = TextEditingController();



  Api api = Api();

  RxBool isLogin = false.obs;


  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  RxBool passwordVisible = true.obs;

  void passwordVisibility() {
    passwordVisible.value = !passwordVisible.value;
  }






}