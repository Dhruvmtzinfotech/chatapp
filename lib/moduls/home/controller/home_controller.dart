import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {

  RxString name = "".obs;
  RxString email = "".obs;
  RxString photo = "".obs;

  googleData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name.value = prefs.getString("name") ?? "";
    email.value = prefs.getString("email") ?? "";
    photo.value = prefs.getString("photo") ?? "";
  }

  RxString senderId="".obs;

  Future<void> getSenderId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    senderId.value = prefs.getString("senderId") ?? "";
    // print("SenderId_________${senderId}");
  }

  @override
  void onInit() {
    super.onInit();
    getSenderId();
  }


}
