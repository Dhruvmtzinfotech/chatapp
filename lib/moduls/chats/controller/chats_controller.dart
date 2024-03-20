import 'package:chatapp/api/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatsController extends GetxController {


  TextEditingController messageController = TextEditingController();
  ScrollController scrollController =  ScrollController();
  RxBool isEmojiPickerVisible = false.obs;


  final _focusNode = FocusNode();


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
  RxString token="".obs;

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    name.value = arguments['name'];
    email.value = arguments['email'];
    photo.value = arguments['photo'];
    receiverId.value = arguments['receiverId'];
    token.value = arguments['token'];
  }








//   class UserPresenceService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final CollectionReference _presenceCollection = FirebaseFirestore.instance.collection('user');
//
//   Future<void> setUserOnline() async {
//   final User? user = _auth.currentUser;
//   if (user != null) {
//   await _presenceCollection.doc(user.uid).set({
//   'isOnline': true,
//   'lastSeen': DateTime.now(),
//   });
//   }
//   }
//
//   Future<void> setUserOffline() async {
//   final User? user = _auth.currentUser;
//   if (user != null) {
//   await _presenceCollection.doc(user.uid).set({
//   'isOnline': false,
//   'lastSeen': DateTime.now(),
//   });
//   }
//   }
//
//   Stream<DocumentSnapshot> getUserPresenceStream(String userId) {
//   return _presenceCollection.doc(userId).snapshots();
//   }
//   }
//
// // Usage
//   void main() async {
//   UserPresenceService presenceService = UserPresenceService();
//
//   await presenceService.setUserOnline();
//
//   String userId = FirebaseAuth.instance.currentUser!.uid;
//   Stream<DocumentSnapshot> userPresenceStream = presenceService.getUserPresenceStream(userId);
//   userPresenceStream.listen((DocumentSnapshot snapshot) {
//   bool isOnline = snapshot['isOnline'];
//   print('User is ${isOnline ? 'online' : 'offline'}');
//   });
//   }


}

