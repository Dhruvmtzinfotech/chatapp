import 'package:chatapp/api/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatsController extends GetxController {


  TextEditingController messageController = TextEditingController();
  // ScrollController scrollController =  ScrollController();

  Api api = Api();

  RxBool isLoading = false.obs;
  RxBool emojiShowing = false.obs;

  String profileUrl = '';
  void updateProfileUrl(String newUrl) {
    profileUrl = newUrl;
  }

  RxString name="".obs;
  RxString email="".obs;
  RxString photo="".obs;
  RxString receiverId="".obs;

  @override
  void onInit() {
    super.onInit();
    // getSenderId();
    final arguments = Get.arguments;
    name.value = arguments['name'];
    email.value = arguments['email'];
    photo.value = arguments['photo'];
    receiverId.value = arguments['receiverId'];
  }




}