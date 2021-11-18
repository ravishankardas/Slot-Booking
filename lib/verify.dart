// ignore_for_file: import_of_legacy_library_into_null_safe, prefer_const_constructors, must_be_immutable

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:slot_book/loginscreen.dart';

class VerifyScreen extends StatefulWidget {
  String name, number;
  VerifyScreen({Key? key, required this.name, required this.number})
      : super(key: key);

  @override
  _VerifyScreenState createState() =>
      _VerifyScreenState(this.name, this.number);
}

class _VerifyScreenState extends State<VerifyScreen> {
  String nameId, numberId;
  _VerifyScreenState(this.nameId, this.numberId);

  final auth = FirebaseAuth.instance;
  late User user;
  late Timer timer;
  @override
  void initState() {
    user = auth.currentUser;
    user.sendEmailVerification();

    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });

    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('An email has been sent to ${user.email} please verify'),
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    Fluttertoast.showToast(msg: "check your email", gravity: ToastGravity.TOP);
    user = auth.currentUser;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    }
  }
}
