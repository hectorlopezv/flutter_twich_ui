import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twich_ui_clone/models/user.dart';
import 'package:twich_ui_clone/utils/storage_methods.dart';
import 'package:twich_ui_clone/utils/utisl.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StorageMethods _storageMethods = StorageMethods();
  Future<void> startLiveStream(
      BuildContext context, String title, Uint8List? image) async {
    final user = Provider.of<User>(context, listen: false);
    try {
      if (title.isNotEmpty && image != null) {
        String thumbailUrl = await _storageMethods.uploadImageToStorage(
          "livestream-thumbnail",
          image,
          user.uid,
        );
        await _firestore.collection('liveStreams').add({
          'title': title,
          'image': image,
          'userId': user.uid,
          'username': user.username,
          'profileImage': thumbailUrl,
          'createdAt': FieldValue.serverTimestamp(),
        });
      } else {
        showSnackBar(context, 'Please enter title and select image');
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
