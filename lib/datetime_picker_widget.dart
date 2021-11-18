// ignore_for_file: import_of_legacy_library_into_null_safe, unnecessary_null_comparison, unused_local_variable, must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
// import 'package:slot_book/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'loginscreen.dart';

class DatetimePickerWidget extends StatefulWidget {
  String em;
  DatetimePickerWidget({Key? key, required this.em}) : super(key: key);
  @override
  _DatetimePickerWidgetState createState() =>
      _DatetimePickerWidgetState(this.em);
}

class _DatetimePickerWidgetState extends State<DatetimePickerWidget> {
  String theDate = '';
  DateTime dateTime = DateTime.now();
  String emailId;
  _DatetimePickerWidgetState(this.emailId);

  String getText() {
    if (dateTime == null || dateTime == '') {
      return 'Select Date and Time';
    } else {
      theDate = DateFormat('MM/dd/yyyy HH:mm').format(dateTime);
      return DateFormat('MM/dd/yyyy HH:mm').format(dateTime);
    }
  }

  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              auth.signOut();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Number of slots available: $pValue',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            // Text(
            //   'Select your Date and Time below',
            //   style: TextStyle(
            //     color: Colors.black,
            //     fontSize: 18,
            //   ),
            // ),
            // Container(
            //   width: 200,
            //   child: ButtonHeaderWidget(
            //     title: '',
            //     text: getText(),
            //     onClicked: () => pickDateTime(context),
            //   ),
            // ),
            ElevatedButton(
              onPressed: shouldEnable ? _pay : null,
              child: Text('Book'),
            ),
          ],
        ),
      ),
    );
  }

  int pValue = 30;
  bool shouldEnable = true;
  int prevValue = 0;

  void _pay() {
    prevValue = pValue;
    if (pValue > 0) {
      setState(() {
        pValue--;
        shouldEnable = false;
      });
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Dear ${emailId.substring(0, emailId.indexOf('@'))}'),
              content:
                  Text('Thanks for booking, your token number is ${prevValue}'),
            );
          });
    } else {
      setState(() {
        shouldEnable = false;
      });
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('hey ${emailId.substring(0, emailId.indexOf('@'))}'),
              content: Text(
                  'we have no slots available now, please come back later'),
            );
          });
      // Fluttertoast.showToast(
      //     msg: 'No slots Available, come back later',
      //     gravity: ToastGravity.TOP);
    }
  }

  Future pickDateTime(BuildContext context) async {
    final date = await pickDate(context);
    if (date == null) return;

    final time = await pickTime(context);
    if (time == null) return;

    setState(() {
      dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  Future<DateTime?> pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (newDate == null) return null;

    return newDate;
  }

  Future<TimeOfDay?> pickTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: dateTime != null
          ? TimeOfDay(hour: dateTime.hour, minute: dateTime.minute)
          : initialTime,
    );

    if (newTime == null) return null;

    return newTime;
  }
}
