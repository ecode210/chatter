import 'package:chatter/model/chatter_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  Rx<ChatterUser> user = ChatterUser().obs;
  RxList<ChatterUser> allUsers = [ChatterUser()].obs;
  RxList currentChat = [].obs;
  final firestore = FirebaseFirestore.instance.collection("chatter");

  void searchUserDatabase({required AsyncSnapshot snapshot}) {
    Object? data;
    for (int i = 0; i < snapshot.data!.docs.length; i++) {
      if (snapshot.data!.docs[i].id == FirebaseAuth.instance.currentUser!.uid) {
        data = snapshot.data!.docs[i].data();
      }
    }
    user.value = ChatterUser.fromJson(data);
  }

  void getAllUsers({required AsyncSnapshot snapshot}) {
    List<ChatterUser> data = [];
    for (int i = 0; i < snapshot.data!.docs.length; i++) {
      if (snapshot.data!.docs[i].id != FirebaseAuth.instance.currentUser!.uid) {
        data.add(ChatterUser.fromJson(snapshot.data!.docs[i].data()));
      }
    }
    allUsers.clear();
    allUsers.value = data;
  }

  Future<bool> updateReceiver({
    required String key,
    required dynamic value,
    required String id,
  }) async {
    DocumentReference doc = firestore.doc("users").collection("chatter").doc(id);
    Map<String, dynamic> data = {
      key: value,
    };

    try {
      await doc.update(data);
      return true;
    } on FirebaseException catch (error) {
      if (kDebugMode) {
        print(error.message);
      }
      return false;
    }
  }

  Future<bool> updateSender({
    required String key,
    required dynamic value,
  }) async {
    final id = FirebaseAuth.instance.currentUser!.uid;
    DocumentReference doc = firestore.doc("users").collection("chatter").doc(id);
    Map<String, dynamic> data = {
      key: value,
    };

    try {
      await doc.update(data);
      return true;
    } on FirebaseException catch (error) {
      if (kDebugMode) {
        print(error.message);
      }
      return false;
    }
  }

  void sendMessage({required TextEditingController message, required String receiverId}) async {
    if (message.text.trim().isEmpty) {
      return;
    }

    await Future.wait([
      updateSender(
        key: "messages.$receiverId",
        value: FieldValue.arrayUnion(
          [
            {
              "is_sender": true,
              "message": message.text.trim(),
            },
          ],
        ),
      ),
      updateReceiver(
        id: receiverId,
        key: "messages.${FirebaseAuth.instance.currentUser!.uid}",
        value: FieldValue.arrayUnion(
          [
            {
              "is_sender": false,
              "message": message.text.trim(),
            },
          ],
        ),
      ),
    ]).then((value) {
      message.clear();
      if (value.every((element) => element == true)) {
        debugPrint("Message sent!");
      } else {
        debugPrint("Message NOT sent: $value");
      }
    });
  }
}
