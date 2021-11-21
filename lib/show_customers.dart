// ignore_for_file: must_be_immutable, import_of_legacy_library_into_null_safe

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:slot_book/owner.dart';

import 'main.dart';

class showCustomers extends StatefulWidget {
  String time;
  late int what;
  showCustomers({Key? key, required this.time, required this.what})
      : super(key: key);

  @override
  _showCustomersState createState() =>
      _showCustomersState(this.time, this.what);
}

class _showCustomersState extends State<showCustomers> {
  String timeId;
  int value;
  final DBref = FirebaseDatabase.instance.reference();
  final DateTime theDate = DateTime.now();
  List contact = ['Welcome'];

  _showCustomersState(this.timeId, this.value);

  @override
  void initState() {
    super.initState();
    if (value == 1) {
      readDataToday();
    } else {
      readDataTomorrow();
    }

    // showData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          timeId,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => ownerWatch(),
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
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => MyApp(),
                ),
              );
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
                height: 200,
                child: Card(
                  elevation: 3,
                  child: Center(
                    child: ListTile(
                      onTap: () {},
                      title: Text(contact[index]),
                      trailing: TextButton(
                        onPressed: () {},
                        child: Text(''),
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

  void readDataToday() async {
    contact.clear();
    String stuff = 'hey there';

    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String today = formatter.format(theDate);
    // final String tomorrow = formatter.format(theDate1);

    String email, time, date, shopName, location;
    await DBref.once().then((DataSnapshot dataSnapshot) {
      setState(() {
        for (String key in dataSnapshot.value.keys) {
          if (key == 'number') {
            continue;
          }
          Map<Object, Object> newMap =
              dataSnapshot.value[key] as Map<Object, Object>;
          email = newMap['Email'].toString();
          date = newMap['Date'].toString();
          location = newMap['Location'].toString();
          time = newMap['Time'].toString();
          shopName = newMap['Shop Name'].toString();
          if (date == today && time == timeId) {
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
          }
        }
      });
    });
  }

  void readDataTomorrow() async {
    contact.clear();
    String stuff = 'hey there';
    final theDate1 = DateTime(theDate.year, theDate.month, theDate.day + 1);

    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    // final String today = formatter.format(theDate);
    final String tomorrow = formatter.format(theDate1);

    String email, time, date, shopName, location;
    await DBref.once().then((DataSnapshot dataSnapshot) {
      setState(() {
        for (String key in dataSnapshot.value.keys) {
          if (key == 'number') {
            continue;
          }
          Map<Object, Object> newMap =
              dataSnapshot.value[key] as Map<Object, Object>;
          email = newMap['Email'].toString();
          date = newMap['Date'].toString();
          location = newMap['Location'].toString();
          time = newMap['Time'].toString();
          shopName = newMap['Shop Name'].toString();
          if (date == tomorrow && time == timeId) {
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
          }
        }
      });
    });
  }
}
