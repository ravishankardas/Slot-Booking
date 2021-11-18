// ignore_for_file: must_be_immutable, deprecated_member_use, unused_element, import_of_legacy_library_into_null_safe, unused_local_variable, unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:slot_book/main.dart';
import 'package:slot_book/pay.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:convert';

class ListScreen extends StatefulWidget {
  String email, shopName, locationShop, timeShop, date, uid;
  ListScreen({
    Key? key,
    required this.email,
    required this.shopName,
    required this.locationShop,
    required this.timeShop,
    required this.date,
    required this.uid,
  }) : super(key: key);
  @override
  _ListScreenState createState() => _ListScreenState(this.email, this.shopName,
      this.locationShop, this.timeShop, this.date, this.uid);
}

class _ListScreenState extends State<ListScreen> {
  final DBref = FirebaseDatabase.instance.reference();
  String emailId, shopId, locId, timeId, dateId, aloha;
  final auth = FirebaseAuth.instance;

  _ListScreenState(this.emailId, this.shopId, this.locId, this.timeId,
      this.dateId, this.aloha);
  List contact = [];
  List userKeys = [];
  int pValue = 0;
  @override
  void initState() {
    super.initState();
    readData();
    // showData();
  }

  Object stuff = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //backgroundColor: primaryColor,
      appBar: AppBar(
        elevation: 0,
        title: Text('Booking Records'),
        // automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => BooknPay(
                  email: emailId,
                  shopName: shopId,
                  location: locId,
                  date: dateId,
                  time: timeId,
                ),
              ),
            );
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              auth.signOut();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => MyApp()));
            },
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: contact.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(10),
                height: 170,
                child: Card(
                  elevation: 3,
                  child: Center(
                    child: ListTile(
                      onTap: () {},
                      title: Text(contact[index]),
                      trailing: TextButton(
                        onPressed: () {
                          setState(() {
                            contact.removeAt(index);
                            DBref.child(auth.currentUser.uid).remove();
                            DBref.child('number').update({
                              'Token': pValue + 1,
                            });
                          });
                          Fluttertoast.showToast(
                            msg: 'Your booking has been cancelled',
                            timeInSecForIosWeb: 1,
                          );
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // void showData() {
  //   if (contact.length == 0) {
  //     Fluttertoast.showToast(
  //       msg: 'Start Booking',
  //       timeInSecForIosWeb: 1,
  //     );
  //   }
  // }

  void readData() async {
    final User user = await auth.currentUser;
    final uid = user.uid;
    String email, time, date, shopName, location;
    await DBref.once().then((DataSnapshot datasnapshot) {
      Map<Object, Object> someMap = datasnapshot.value;
      setState(() {
        Map<Object, dynamic> newMap = someMap[uid] as Map<Object, dynamic>;
        email = newMap['Email'].toString();
        date = newMap['Date'].toString();
        location = newMap['Location'].toString();
        time = newMap['Time'].toString();
        shopName = newMap['Shop Name'].toString();
        stuff = email +
            '\n' +
            shopName +
            '\n' +
            location +
            '\n' +
            date +
            '\n' +
            time;
        print(stuff);
        contact.add(stuff);
      });
    });
    DBref.child('number').once().then((DataSnapshot dataSnapshot) {
      setState(() {
        pValue = dataSnapshot.value['Token'];
      });
    });
  }
}
