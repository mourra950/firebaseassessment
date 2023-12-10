import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseassessment/Todo.dart';

class FBase {
  static final _firebaseauth = FirebaseAuth.instance;
  static final _firebasestore = FirebaseFirestore.instance;

  static late User userhandler;
  FBase();
  Future<String> createUser(
      String userName, String userEmail, String pass) async {
    try {
      var userCred = await _firebaseauth.createUserWithEmailAndPassword(
          email: userEmail, password: pass);
      var user = userCred.user;

      await FirebaseFirestore.instance
          .collection("userinfo")
          .doc(user!.uid)
          .set({
        'username': userName,
        'email': userEmail,
      });
    } on FirebaseAuthException catch (error) {
      return error.message ?? 'Authentication failed';
    }
    return 'Success';
  }

  Future<String> signIn(String userEmail, String pass) async {
    try {
      var userCred = await _firebaseauth.signInWithEmailAndPassword(
          email: userEmail, password: pass);
      userhandler = userCred.user!;
    } on FirebaseAuthException catch (error) {
      return error.message ?? 'Authentication failed';
    }
    return 'Success';
  }

  Future addcard(Todo card) async {
    _firebasestore.collection('cards').add({
      'taskname': card.item,
      'taskprio': card.prio,
      'usermail': userhandler.email
    });
    await readcards();
  }

  Future readcards() async {
    List<Todo> templist = [];
    final docRef = _firebasestore
        .collection("cards")
        .where('usermail', isEqualTo: userhandler.email);
    await docRef.get().then((values) {
      for (var value in values.docs) {
        templist.add(Todo.firebase(
            value.data()['taskprio'], value.data()['taskname'], value.id));
      }
      Todo.tolist = templist;
    });
  }

  Future deletecards(String id) async {
    await _firebasestore.collection("cards").doc(id).delete();
    await readcards();
  }
}
