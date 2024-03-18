import 'dart:io';
import 'package:chatapp/moduls/chats/controller/chats_controller.dart';
import 'package:chatapp/moduls/home/controller/home_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


class ChatsView extends StatefulWidget {
  const ChatsView({super.key});

  @override
  State<ChatsView> createState() => _ChatsViewState();
}

class _ChatsViewState extends State<ChatsView> {
  HomeController homeCon = Get.put(HomeController());
  ChatsController chatsCon = Get.put(ChatsController());
  final ImagePicker picker = ImagePicker();
  File? selectedFile;

   //final _messagingService = MessagingService();



  @override
  void initState() {
    super.initState();
    homeCon.getSenderId();
     //_messagingService.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: (){
                          Get.back();
                        },
                      ),
                      CircleAvatar(
                        backgroundImage: NetworkImage(chatsCon.photo.value),
                        radius: 20,
                      ),
                      SizedBox(width: 10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(chatsCon.name.value),
                          Text(chatsCon.email.value),
                        ],
                      ),
                    ],
                  ),
                  Expanded(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance.collection("user").doc(homeCon.senderId.value)
                          .collection("chats").doc(chatsCon.receiverId.value).collection("message")
                          .orderBy("datetime", descending: true).snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)
                      {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                          return ListView(
                            reverse: true,
                            children: snapshot.data!.docs.map((document) {
                              if (homeCon.senderId.value == document["senderId"].toString()) {
                                return Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    margin: EdgeInsets.all(10.0),
                                    padding: EdgeInsets.all(10.0),
                                    child: (document["type"]=="image")?Image.network(document["message"].toString(),width: 200,):Text(document["message"].toString(),style: TextStyle(color: Colors.white),),
                                    decoration: BoxDecoration(
                                        color: Color(0xff20A090),
                                        borderRadius: BorderRadius.circular(15.0)
                                    ),
                                  ),
                                );
                              } else {
                                return Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    margin: EdgeInsets.all(10.0),
                                    padding: EdgeInsets.all(10.0),
                                    child:  (document["type"]=="image")?Image.network(document["message"].toString(),width: 200,):Text(document["message"].toString(),style: TextStyle(color: Colors.white),),
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(10.0)
                                    ),
                                  ),
                                );
                              }
                            }).toList(),
                          );
                        } else {
                          return Center(child: Text("No Data"));
                        }
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Column(
                              children: [
                                TextField(
                                  controller: chatsCon.messageController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Type a Message',
                                    prefixIcon: GestureDetector(
                                        onTap: () async{
                                          // setState(() {
                                          //   FocusManager.instance.primaryFocus?.unfocus();
                                          //   chatsCon.emojiShowing.value = chatsCon.emojiShowing.value;
                                          // });
                                        },
                                        child: Icon(Icons.emoji_emotions_outlined)),
                                    suffixIcon: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.min,
                                      children:[
                                        IconButton(
                                          icon: Icon(Icons.camera_alt),
                                          onPressed: () async {
                                            final picker = ImagePicker();
                                            final XFile? photo = await picker.pickImage(source: ImageSource.camera);
                                            if (photo == null) return;

                                            setState(() {
                                              chatsCon.isLoading.value = true;
                                            });

                                            File selectedFile = File(photo.path);
                                            var id = DateTime.now().microsecondsSinceEpoch.toString();
                                            try {
                                              TaskSnapshot uploadTask = await FirebaseStorage.instance
                                                  .ref('camera/camera$id') // Folder nam  ed "images"
                                                  .putFile(selectedFile);
                                              String imageUrl = await uploadTask.ref.getDownloadURL();
                                              await FirebaseFirestore.instance
                                                  .collection("user")
                                                  .doc(homeCon.senderId.value)
                                                  .collection("chats")
                                                  .doc(chatsCon.receiverId.value)
                                                  .collection("message")
                                                  .add({
                                                "senderId": homeCon.senderId.value,
                                                "message": imageUrl,
                                                "receiverId": chatsCon.receiverId.value,
                                                "type": "image",
                                                "datetime": DateTime.now().millisecondsSinceEpoch
                                              });
                                              await FirebaseFirestore.instance
                                                  .collection("user")
                                                  .doc(chatsCon.receiverId.value)
                                                  .collection("chats")
                                                  .doc(homeCon.senderId.value)
                                                  .collection("message")
                                                  .add({
                                                "senderId": homeCon.senderId.value,
                                                "message": imageUrl,
                                                "receiverId": chatsCon.receiverId.value,
                                                "type": "image",
                                                "datetime": DateTime.now().millisecondsSinceEpoch
                                              });
                                              setState(() {
                                                chatsCon.isLoading.value = false;
                                              });
                                            } catch (error) {
                                              print("Error uploading image: $error");
                                            }
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.photo),
                                          onPressed: () async {
                                            final picker = ImagePicker();
                                            try {
                                              final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
                                              if (photo == null) return;

                                              setState(() {
                                                chatsCon.isLoading.value = true;
                                              });

                                              File selectedFile = File(photo.path);
                                              var id = DateTime.now().microsecondsSinceEpoch.toString();

                                              // Upload image to Firebase Storage
                                              TaskSnapshot uploadTask = await FirebaseStorage.instance
                                                  .ref('photos$id')
                                                  .putFile(selectedFile);

                                              String imageUrl = await uploadTask.ref.getDownloadURL();

                                              // Add image reference to Firestore
                                              await FirebaseFirestore.instance
                                                  .collection("user")
                                                  .doc(homeCon.senderId.value)
                                                  .collection("chats")
                                                  .doc(chatsCon.receiverId.value)
                                                  .collection("message")
                                                  .add({
                                                "senderId": homeCon.senderId.value,
                                                "message": imageUrl,
                                                "receiverId": chatsCon.receiverId.value,
                                                "type": "image",
                                                "datetime": DateTime.now().millisecondsSinceEpoch
                                              });

                                              await FirebaseFirestore.instance
                                                  .collection("user")
                                                  .doc(chatsCon.receiverId.value)
                                                  .collection("chats")
                                                  .doc(homeCon.senderId.value)
                                                  .collection("message")
                                                  .add({
                                                "senderId": homeCon.senderId.value,
                                                "message": imageUrl,
                                                "receiverId": chatsCon.receiverId.value,
                                                "type": "image",
                                                "datetime": DateTime.now().millisecondsSinceEpoch
                                              });

                                              setState(() {
                                                chatsCon.isLoading.value = false;
                                              });
                                            } catch (error) {
                                              print("Error uploading image: $error");
                                              setState(() {
                                                chatsCon.isLoading.value = false;
                                              });
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      MaterialButton(
                        onPressed: ()  async{
                          var message = chatsCon.messageController.text.toString();
                          if(message.length!=0)
                            {
                              chatsCon.messageController.clear();

                              await FirebaseFirestore.instance.collection("user").doc(homeCon.senderId.value)
                                  .collection("chats").doc(chatsCon.receiverId.value).collection("message").add({
                                "senderId":homeCon.senderId.value,
                                "receiverId":chatsCon.receiverId.value,
                                "message":message,
                                "type":"text",
                                "datetime":DateTime.now().millisecondsSinceEpoch,
                              }).then((value) async{
                                await FirebaseFirestore.instance.collection("user").doc(chatsCon.receiverId.value)
                                    .collection("chats").doc(homeCon.senderId.value).collection("message").add({
                                  "senderId":homeCon.senderId.value,
                                  "receiverId":chatsCon.receiverId.value,
                                  "message":message,
                                  "type":"text",
                                  "datetime":DateTime.now().millisecondsSinceEpoch
                                }).then((value) async {
                                  await chatsCon.api.sendPushNotification(
                                    title: "this is text",
                                    body: "this is body",
                                    to:chatsCon.receiverId.value
                                  )!.then((value) async{
                                    if(chatsCon.isLoading.value = true) {
                                    }
                                    else {
                                    }
                                  });
                                });
                              });
                            }
                        },
                        color: Colors.green,
                        textColor: Colors.white,
                        child: Icon(Icons.send, size: 24),
                        padding: EdgeInsets.all(15),
                        shape: CircleBorder(),
                      ),
                    ],
                  ),
                ],
              );
            })
          )
      ),
    );
  }
}
