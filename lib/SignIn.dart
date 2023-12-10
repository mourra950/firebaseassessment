import 'package:flutter/material.dart';
import 'firebase.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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

  void _signin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    String message = await firebasehandler.signIn(useremail, pass);
    showSnackBar(message);
    if (message == "Success") {
      gotomainpage();
    }
  }

  Future<Object?> gotomainpage() =>
      Navigator.pushReplacementNamed(context, '/MainPage');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Sign in page"),
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
                  validator: (value) {
                    if (value!.trim() == '') return "Can't be null";
                    return null;
                  },
                  onSaved: (value) {
                    useremail = value!;
                  },
                  decoration: InputDecoration(hintText: "Useremail"),
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.trim() == '') return "Can't be null";
                    return null;
                  },
                  onSaved: (value) {
                    pass = value!;
                  },
                  obscureText: false,
                  decoration: InputDecoration(hintText: "Password"),
                ),
                ElevatedButton(
                  onPressed: () {
                    _signin();
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
