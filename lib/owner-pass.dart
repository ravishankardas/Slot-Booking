// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:slot_book/owner.dart';

class ownerLogin extends StatefulWidget {
  const ownerLogin({Key? key}) : super(key: key);

  @override
  _ownerLoginState createState() => _ownerLoginState();
}

class _ownerLoginState extends State<ownerLogin> {
  final auth = FirebaseAuth.instance;

  String _email = '', _password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Owner log-in'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),
            ),
            ElevatedButton(
              onPressed: () => _login(_email, _password),
              child: Text('login'),
            )
          ],
        ),
      ),
    );
  }

  _login(String _email, String _password) async {
    try {
      await auth.signInWithEmailAndPassword(email: _email, password: _password);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ownerWatch(),
        ),
      );
    } on FirebaseAuthException catch (error) {
      Fluttertoast.showToast(msg: error.message, gravity: ToastGravity.TOP);
    }
  }
}
