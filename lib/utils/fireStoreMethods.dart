import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twich_ui_clone/models/liverStream.dart';

import 'package:twich_ui_clone/providers/user_provider.dart';
import 'package:twich_ui_clone/utils/storage_methods.dart';
import 'package:twich_ui_clone/utils/utisl.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StorageMethods _storageMethods = StorageMethods();
  Future<String> startLiveStream(
      BuildContext context, String title, Uint8List? image) async {
    String channelId = "";
    final user = Provider.of<UserProvider>(context, listen: false);
    try {
      final isExists =
          await _firestore.collection("livestream").doc(user.user.uid).get();
      if (title.isNotEmpty && image != null) {
        if (!isExists.exists) {
          String thumbailUrl = await _storageMethods.uploadImageToStorage(
            "livestream-thumbnail",
            image,
            user.user.uid,
          );

          channelId = "${user.user.uid}${user.user.username}";
          final LiveStream liveStream = LiveStream(
            title: title,
            image: thumbailUrl,
            uid: user.user.uid,
            username: user.user.username,
            channelId: channelId,
            startedAt: DateTime.now().toIso8601String(),
            viewers: 0,
          );
          _firestore.collection("livestream").doc(channelId).set(
                liveStream.toMap(),
              );
        } else {
          showSnackBar(context, 'Only one liveSTREAM per User');
        }
     
      } else {
        showSnackBar(context, 'Please enter title and select image');
      }
      return channelId;
    } on FirebaseException catch (e) {
      print(e.message!);
      showSnackBar(context, e.message!);
      return channelId;
    }
  }
}
