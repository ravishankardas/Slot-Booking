// ignore_for_file: unused_import, avoid_unnecessary_containers, import_of_legacy_library_into_null_safe, unused_local_variable, prefer_typing_uninitialized_variables, avoid_print, prefer_const_constructors, camel_case_types, must_be_immutable, unused_element

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mailer/mailer.dart';
import 'package:slot_book/bookslot.dart';
import 'package:slot_book/createaccount.dart';
import 'package:slot_book/owner-pass.dart';
import 'package:slot_book/owner.dart';
import 'package:slot_book/reset.dart';

import 'main.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String _email, _password;
  final auth = FirebaseAuth.instance;
  late final User firebaseUser;
  final DBref = FirebaseDatabase.instance.reference();
  String passWord = '', checkPassword = '';
  final ownerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //backgroundColor: primaryColor,
      appBar: AppBar(
        //backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Login'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => ownerLogin(),
                ),
              );
            },
            icon: Icon(
              Icons.account_box,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: <Widget>[
            Text(
              '',
              textAlign: TextAlign.center,
              style: GoogleFonts.openSans(color: Colors.white, fontSize: 28),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                //controller: _text,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: "Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
                onChanged: (value) {
                  setState(() {
                    _email = value.trim();
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                //controller: _text,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password(atleast 6-letter)",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _password = value.trim();
                  });
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () => _login(_email, _password),
              child: Text('login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => ResetScreen()),
                );
              },
              child: Text('Forgot Password?'),
            ),
            TextButton(
              child: Text('New user ? Create an Account'),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => CreateAccount(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.add_sharp,
        children: [
          SpeedDialChild(
            backgroundColor: Colors.amber,
            child: Icon(FontAwesomeIcons.twitter),
            onTap: () {},
          ),
          SpeedDialChild(
            backgroundColor: Colors.amber,
            child: Icon(FontAwesomeIcons.facebook),
            onTap: () {},
          ),
          SpeedDialChild(
            backgroundColor: Colors.amber,
            child: Icon(FontAwesomeIcons.instagram),
            onTap: () {},
          ),
          SpeedDialChild(
            backgroundColor: Colors.amber,
            child: Icon(FontAwesomeIcons.whatsapp),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  goPage() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ownerLogin(),
      ),
    );
  }

  getCred() {
    DBref.child('owner').once().then((DataSnapshot datasnapshot) {
      setState(() {
        checkPassword = datasnapshot.value['pass'];
        passWord = ownerController.text;
      });
    });

    if (passWord == checkPassword) {
      Navigator.of(context).pop();
      goPage();
    } else {
      ownerController.clear();
      Fluttertoast.showToast(msg: 'Enter correct password');
    }
  }

  _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Owner Login"),
          content: TextFormField(
            obscureText: true,
            controller: ownerController,
            decoration: InputDecoration(
              labelText: 'Enter Password',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Enter"),
              onPressed: getCred,
            ),
            Text(passWord),
          ],
        );
      },
    );
  }

  _login(String _email, String _password) async {
    try {
      await auth.signInWithEmailAndPassword(email: _email, password: _password);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => BookSlot(
            em: _email,
          ),
        ),
      );
    } on FirebaseAuthException catch (error) {
      Fluttertoast.showToast(msg: error.message, gravity: ToastGravity.TOP);
    }
  }
}
