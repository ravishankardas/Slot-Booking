// ignore_for_file: unused_local_variable, import_of_legacy_library_into_null_safe, dead_code

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:slot_book/show_customers.dart';

import 'main.dart';

class ownerWatch extends StatefulWidget {
  const ownerWatch({Key? key}) : super(key: key);

  @override
  _ownerWatchState createState() => _ownerWatchState();
}

class _ownerWatchState extends State<ownerWatch> {
  List contact = [];
  final DBref = FirebaseDatabase.instance.reference();
  final DateTime theDate = DateTime.now();
  late int val;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customers'),
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
                height: 70,
                child: Card(
                  elevation: 3,
                  child: Center(
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => showCustomers(
                              time: contact[index],
                              what: val,
                            ),
                          ),
                        );
                      },
                      title: Text(contact[index]),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
            child: Icon(Icons.copy),
            label: 'Today',
            onTap: addToday,
          ),
          SpeedDialChild(
            child: Icon(Icons.copy),
            label: 'Tomorrow',
            onTap: addTomorrow,
          ),
        ],
      ),
    );
  }

  void addToday() {
    List addthis = [
      '9:00 AM to 11:00 AM',
      '11:30 AM to 1:30 PM',
      '2:00 PM to 4:00 PM',
      '4:30 PM to 6:30 PM',
      '7:00 PM to 9:00 PM',
      '9:30 PM to 11:30 PM',
    ];
    contact.clear();
    setState(() {
      val = 1;
      for (String slot in addthis) {
        contact.add(slot);
      }
    });
  }

  void addTomorrow() {
    List addthis = [
      '9:00 AM to 11:00 AM',
      '11:30 AM to 1:30 PM',
      '2:00 PM to 4:00 PM',
      '4:30 PM to 6:30 PM',
      '7:00 PM to 9:00 PM',
      '9:30 PM to 11:30 PM',
    ];
    contact.clear();
    setState(() {
      val = 0;
      for (String slot in addthis) {
        contact.add(slot);
      }
    });
  }
}
