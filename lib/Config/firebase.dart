import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:khalesi/Features/Home/presentaties/click_page.dart';
import 'package:khalesi/main.dart';

Future<void> setUpFirebase() async {
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBHwUUaWZKeqGl08_KajIS7Iqi5feq82x4",
        appId: "1:932729475257:android:04b985fbc92ea9d0068b68",
        messagingSenderId: "932729475257",
        projectId: "alkhalissi-c3ed3",
      ),
    );
    await FirebaseMessaging.instance.subscribeToTopic("general");

    await FirebaseApi().inintNotifications();
  }
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  Future<void> inintNotifications() async {
    await _firebaseMessaging.requestPermission();

    _firebaseMessaging.getInitialMessage();
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      int id = int.parse(message.data["id"]);

      if (id != 0) {
        print(id);
        navigatorKey.currentState!.push(MaterialPageRoute(
          builder: (context) {
            return ClickPage(id: id, categoryTitle: "اخبار ونشاطات");
          },
        ));
      }
      print(message);
    });

    _firebaseMessaging
        .getInitialMessage()
        .then((RemoteMessage? initialMessage) {
      int id = int.parse(initialMessage?.data["id"]);

      if (id != 0) {
        navigatorKey.currentState!.push(MaterialPageRoute(
          builder: (context) {
            return ClickPage(id: id, categoryTitle: "اخبار ونشاطات");
          },
        ));
      }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      int id = int.parse(message.data["id"]);
      if (id != 0) {
        navigatorKey.currentState!.push(MaterialPageRoute(
          builder: (context) {
            return ClickPage(id: id, categoryTitle: "اخبار ونشاطات");
          },
        ));
      }
    });
  }
}

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  log("title :${message.notification?.title}");
  log("body :${message.notification?.body}");
  log("payload :${message.data}");
  log("id == ${message.data["id"]}");
}
