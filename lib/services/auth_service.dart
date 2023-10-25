import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:derm_ai_scan/models/user.dart' as usr;
import 'package:firebase_storage/firebase_storage.dart';

class AuthService {
  static final _firebaseAuth = FirebaseAuth.instance;

  static User? get currentUser => _firebaseAuth.currentUser;

  static Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  static Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future<void> signupUser(
      {required usr.User newUser, required String password}) async {
    _firebaseAuth
        .createUserWithEmailAndPassword(
          email: newUser.email,
          password: password,
        )
        .then((value) => {createUser(value.user!.uid, newUser)});
  }

  static Future<void> logoutUser() async {
    await _firebaseAuth.signOut();
  }

  static Future<void> createUser(String userId, usr.User newUser) async {
    await FirebaseFirestore.instance.collection('Users').doc(userId).set(
          newUser.toMap(),
        );
  }

  static Future<void> updateUser(usr.User updatedUser) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance.collection('Users').doc(userId).update(
          updatedUser.toMap(),
        );
  }

  static Future<usr.User> getUser() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    try {
      usr.User myUser = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .get()
          .then(
            (value) => usr.User.fromMap(value.data()!),
          );
      return myUser;
    } catch (e) {
      return usr.User.empty;
    }
  }

  static Future<String> updateUserPicture(String imagePath) async {
    // String userId = FirebaseAuth.instance.currentUser!.uid;
    Reference reference = FirebaseStorage.instance.ref();
    Reference usersReference = reference.child('users');
    String uniqueName = DateTime.now().toString();
    Reference userImageReference = usersReference.child(uniqueName);
    // try {
    //   await userImageReference.delete();
    // } catch (e) {}
    await userImageReference.putFile(File(imagePath));
    String url = await userImageReference.getDownloadURL();
    return url;
  }

  static Future<void> forgetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
