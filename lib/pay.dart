// ignore_for_file: unused_field, import_of_legacy_library_into_null_safe, must_be_immutable, unused_local_variable, unused_import, unused_element, duplicate_import, must_call_super

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:slot_book/account.dart';
import 'package:slot_book/bookslot.dart';
import 'package:slot_book/loginscreen.dart';
import 'package:slot_book/main.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BooknPay extends StatefulWidget {
  String email, shopName, location, date, time;
  BooknPay({
    Key? key,
    required this.email,
    required this.shopName,
    required this.location,
    required this.date,
    required this.time,
  }) : super(key: key);

  @override
  _BooknPayState createState() => _BooknPayState(
      this.email, this.shopName, this.location, this.date, this.time);
}

class _BooknPayState extends State<BooknPay> {
  String userId = '';
  final DBref = FirebaseDatabase.instance.reference();
  final auth = FirebaseAuth.instance;
  late final User firebaseUser;

  String emailId, shopId, locId, dateId, timeId;

  var someAnoter;
  _BooknPayState(
      this.emailId, this.shopId, this.locId, this.dateId, this.timeId);
  @override
  void initState() {
    super.initState();
    readData();
    // showData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(shopId),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: goTO,
              icon: Icon(
                Icons.account_box,
                color: Colors.white,
              )),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Row(
              children: [
                Text(
                  'Number of slots available: $pValue',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: oneClick ? sendEmail : null,
            child: Text('Book'),
          ),
        ],
      ),
    );
  }

  someAnother() {}

  writeData() async {
    final User user = await auth.currentUser;
    final uid = user.uid;
    // setState(() {
    //   userId = uid;
    // });
    userId = uid;
    DBref.child(uid).set({
      'Email': emailId,
      'Time': timeId,
      'Location': locId,
      'Shop Name': shopId,
      'Date': dateId,
    });
    // DBref.child('number').set({
    //   'Token': pValue,
    // });
  }

  readData() {
    DBref.child('number').once().then((DataSnapshot dataSnapshot) {
      Map<Object, Object> someMap = dataSnapshot.value;
      setState(() {
        pValue = dataSnapshot.value['Token'];
      });
    });
  }

  void goTO() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ListScreen(
            email: emailId,
            timeShop: timeId,
            date: dateId,
            locationShop: locId,
            shopName: shopId,
            uid: userId),
      ),
    );
  }

  bool shouldEnable = false;
  bool oneClick = true;
  int prevValue = 0;
  int pValue = 0;

  Future sendEmail() async {
    // readData();
    prevValue = pValue;
    if (pValue > 0) {
      setState(() {
        --pValue;
        DBref.child('number').update({
          'Token': pValue,
        });
        shouldEnable = true;
        oneClick = false;
      });
    } else {
      setState(() {
        shouldEnable = false;
      });
    }
    GoogleAuthApi.signOut();
    final user = await GoogleAuthApi.signIn();
    if (user == null) return;
    final email = user.email;
    final auth = await user.authentication;
    final token = auth.accessToken!;
    print('Authenticated: $email');
    // GoogleAuthApi.signOut();
    final smtpServer = gmailSaslXoauth2(email, token);
    final message = Message()
      ..from = Address(email, 'Book Slot')
      ..recipients = [emailId]
      ..subject = 'Booking Confirmation'
      ..text =
          'Dear user, \n You have booked the ${timeId} slot on ${dateId} for ${shopId} which is located at ${locId} and your token number is ${prevValue}, Happy Shopping!!!';
    try {
      await send(message, smtpServer);
      Fluttertoast.showToast(
        msg: 'Details of your booking is sent to your email $emailId',
        timeInSecForIosWeb: 1,
      );
    } on MailerException catch (e) {
      print(e);
    }
    // readData();
    writeData();
  }
}

mixin FirebaseUser {}

class GoogleAuthApi {
  static final _googleSignIn =
      GoogleSignIn(scopes: ['https://mail.google.com/']);

  static Future<GoogleSignInAccount?> signIn() async {
    if (await _googleSignIn.isSignedIn()) {
      return _googleSignIn.currentUser;
    } else {
      return await _googleSignIn.signIn();
    }
  }

  static Future signOut() => _googleSignIn.signOut();
}
