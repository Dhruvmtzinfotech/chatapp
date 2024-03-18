import 'dart:convert';
import 'package:chatapp/api/widget.dart';
import 'package:chatapp/utils/constrants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/helper.dart';

class Api{

  Dio dio = Dio (BaseOptions(
    baseUrl:Constants.baseUrl,
    contentType: "application/json",
  ));

  Future? header() async {
    String? token;
    await Helper.getUserToken().then((value) {
      token = value;
    });
    if (kDebugMode) {
      print(token);
    }
    return dio.options.headers["Authorization"] = "Bearer $token";
  }

  Future? getUserLogin({String? email,String? password}) async {
    Map<String,dynamic> map = {"email":email,"password":password};
    String body= jsonEncode(map);
    try{
      var headers = {
        'Content-Type': 'application/json',
      };
      var response = await dio.post('login',data: body,options: Options(headers: headers));
      if(response.statusCode == 200 || response.statusCode == 201){
        if(response.data["user"] != null){

          var name = response.data['user']['name'];
          var role = response.data['user']['role'];
          var mobile = response.data['user']['phoneNumber'];
          var token = response.data['token'];

          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("isLogin", "yes");
          prefs.setString('name', name);
          prefs.setString('email', email!);
          prefs.setString('phoneNumber',mobile);
          prefs.setString('role', role);
          prefs.setString('token', token);
          
          return response.data;
        }
      }

    }
    on DioException catch(ex){
      return apiDialog(ex.response!.data['message'] ?? "Please try again");
    }
  }

  Future? sendPushNotification({String? title, String? body, String? to }) async {
    Map<String,dynamic> map = {"notification":{"title":title,"body":body},"to":to};
    String requestBody = jsonEncode(map);

    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer AAAAKZ9-00w:APA91bG60aXsIIJSQhTfC1-aUctV6JNj4LR280H4GDyNgnnsrwItJXfCSR1sO7Ao7E_sZKXpw5n21-oyZn7FP3KamOt2mTdZK2V4dWun7jOR8W3eaEx1Hsw_nc9VQ8RK4tA7M_6w0Tko'
      };
      var response = await dio.post('https://fcm.googleapis.com/fcm/send',
        data: requestBody,
        options: Options(headers: headers),
      );

      if(response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.data}');
    }
    on DioException catch (ex) {
      print('sendPushNotificationE: $ex');
    }
  }


}

// final body = {
//   "to": chatUser.pushToken,
//   "notification": {
//     "title": name,
//     "body": msg,
//     "android_channel_id": "chats"
//   },
// };