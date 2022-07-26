import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twich_ui_clone/models/user.dart' as models;
import 'package:twich_ui_clone/providers/user_provider.dart';
import 'package:twich_ui_clone/utils/utisl.dart';

class AuthMethods {
  final _userRef = FirebaseFirestore.instance.collection("users");
  final _auth = FirebaseAuth.instance;

  Future<Map<String, dynamic>?> getCurrentUser(String? uid) async {
    if (uid != null) {
      final snap = await _userRef.doc(uid).get();
      return snap.data();
    }
    return null;
  }

  Future<bool> signUpUser({
    required BuildContext context,
    required String username,
    required String password,
    required String email,
  }) async {
    bool res = false;
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (cred.user != null) {
        models.User user = models.User(
          uid: cred.user!.uid,
          username: username.trim(),
          email: email.trim(),
        );

        await _userRef.doc(cred.user!.uid).set(user.toMap());
        res = true;
        Provider.of<UserProvider>(context, listen: false).setUser(user);
        return res;
      }
      return res;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      showSnackBar(context, e.message!);
      return res;
    }
  }

  Future<bool> loginUser({
    required BuildContext context,
    required String password,
    required String email,
  }) async {
    bool res = false;
    try {
      UserCredential cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (cred != null) {
        final user = await getCurrentUser(
          cred.user!.uid,
        );

        Provider.of<UserProvider>(context, listen: false)
            .setUser(models.User.fromMap(user ?? {}));
        res = true;
      }

      return res;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      showSnackBar(context, e.message!);
      return res;
    }
  }
}
