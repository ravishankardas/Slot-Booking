// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:slot_book/pay.dart';

class SlotDivison extends StatefulWidget {
  String email, shop, location, date;
  SlotDivison({
    Key? key,
    required this.email,
    required this.shop,
    required this.location,
    required this.date,
  }) : super(key: key);

  @override
  _SlotDivisonState createState() => _SlotDivisonState(
        this.email,
        this.shop,
        this.location,
        this.date,
      );
}

class _SlotDivisonState extends State<SlotDivison> {
  String theEmail, theShop, theLocation, theDate;
  _SlotDivisonState(
    this.theEmail,
    this.theShop,
    this.theLocation,
    this.theDate,
  );
  List contact = [
    '9:00 AM to 11:00 AM',
    '11:30 AM to 1:30 PM',
    '2:00 PM to 4:00 PM',
    '4:30 PM to 6:30 PM',
    '7:00 PM to 9:00 PM',
    '9:30 PM to 11:30 PM',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //backgroundColor: primaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text("Slots"),
      ),
      body: SafeArea(
        child: Container(
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: contact.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 3,
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => BooknPay(
                          email: theEmail,
                          shopName: theShop,
                          location: theLocation,
                          date: theDate,
                          time: contact[index],
                        ),
                      ),
                    );
                  },
                  // leading: CircleAvatar(
                  //   child: Text(contact[index].toString().split(" ")[0][0]),
                  // ),
                  title: Text(contact[index]),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
