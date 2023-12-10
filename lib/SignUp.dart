// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final db = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  var username = '';
  var useremail = '';
  var firebasehandler = FBase();
  var pass = '';

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _signup() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    String message =
        await firebasehandler.createUser(username, useremail, pass);
    showSnackBar(message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Sign Up page"),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: SizedBox(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(hintText: "Username"),
                  validator: (value) {
                    if (value!.trim() == '') return "Can't be null";
                    return null;
                  },
                  onSaved: (value) {
                    username = value!;
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Useremail",
                        ),
                        validator: (value) {
                          if (value!.trim() == '') return "Can't be null";
                          return null;
                        },
                        onSaved: (value) {
                          useremail = value!;
                        },
                      ),
                    ),
                    Text("@eng.asu.edu.eg"),
                  ],
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: "Password"),
                  validator: (value) {
                    if (value!.trim() == '') {
                      return "Can't be null";
                    } else if (value.trim().length < 6) {
                      return "too short";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    pass = value!;
                  },
                  obscureText: false,
                ),
                ElevatedButton(
                  onPressed: () {
                    _signup();
                  },
                  child: Text("Submit"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
