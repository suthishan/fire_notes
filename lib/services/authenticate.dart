import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_firebase_task/constants/AppConstants.dart';
import 'package:flutter_firebase_task/model/addnotes.dart';
import 'package:flutter_firebase_task/model/user.dart';
import 'package:flutter_firebase_task/services/helper.dart';

class FireStoreUtils {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Future<User?> getCurrentUser(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> userDocument =
        await firestore.collection(USERS).doc(uid).get();
    if (userDocument.data() != null && userDocument.exists) {
      return User.fromJson(userDocument.data()!);
    } else {
      return null;
    }
  }

  static Future<User> updateCurrentUser(User user) async {
    return await firestore
        .collection(USERS)
        .doc(user.userID)
        .set(user.toJson())
        .then((document) {
      return user;
    });
  }

  static Future<dynamic> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      auth.UserCredential result = await auth.FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await firestore.collection(USERS).doc(result.user?.uid ?? '').get();
      User? user;
      if (documentSnapshot.exists) {
        user = User.fromJson(documentSnapshot.data() ?? {});
      }
      return user;
    } on auth.FirebaseAuthException catch (exception, s) {
      print(exception.toString() + '$s');
      switch ((exception).code) {
        case 'invalid-email':
          return 'Email address is malformed.';
        case 'wrong-password':
          return 'Wrong password.';
        case 'user-not-found':
          return 'No user corresponding to the given email address.';
        case 'user-disabled':
          return 'This user has been disabled.';
        case 'too-many-requests':
          return 'Too many attempts to sign in as this user.';
      }
      return 'Unexpected firebase error, Please try again.';
    } catch (e, s) {
      print(e.toString() + '$s');
      return 'Login failed, Please try again.';
    }
  }

  static Future<String?> firebaseCreateNewUser(User user) async =>
      await firestore
          .collection(USERS)
          .doc(user.userID)
          .set(user.toJson())
          .then((value) => null, onError: (e) => e);

  static firebaseSignUpWithEmailAndPassword(
    String emailAddress,
    String password,
    String name,
  ) async {
    try {
      auth.UserCredential result = await auth.FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailAddress, password: password);
      User user = User(
        email: emailAddress,
        name: name,
        userID: result.user?.uid ?? '',
      );
      String? errorMessage = await firebaseCreateNewUser(user);
      if (errorMessage == null) {
        return user;
      } else {
        return 'Couldn\'t sign up for firebase, Please try again.';
      }
    } on auth.FirebaseAuthException catch (error) {
      print(error.toString() + '${error.stackTrace}');
      String message = 'Couldn\'t sign up';
      switch (error.code) {
        case 'email-already-in-use':
          message = 'Email already in use, Please pick another email!';
          break;
        case 'invalid-email':
          message = 'Enter valid e-mail';
          break;
        case 'operation-not-allowed':
          message = 'Email/password accounts are not enabled';
          break;
        case 'weak-password':
          message = 'Password must be more than 5 characters';
          break;
        case 'too-many-requests':
          message = 'Too many requests, Please try again later.';
          break;
      }
      return message;
    } catch (e) {
      return 'Couldn\'t sign up';
    }
  }

  static Future<String?> adduserFirebase(AddUserModel adduser) async {
    print(adduser);
    await firestore
        .collection(ADD_USERS)
        .doc()
        .set(adduser.toJson())
        .whenComplete(() => print("user item added to the database"))
        .catchError((e) => print(e));
  }

  static Future addUserFirebase(
    String firstname,
    String lastname,
    String email,
  ) async {
    try {
      AddUserModel adduser = AddUserModel(
        firstname: firstname,
        lastname: lastname,
        email: email,
      );

      String? errorMessage = await adduserFirebase(adduser);
      print(errorMessage);
      if (errorMessage == null) {
        return adduser;
      } else {
        return 'Couldn\'t sign up for firebase, Please try again.';
      }

      // return user;
    } on auth.FirebaseAuthException catch (error) {
      print(error.toString() + '${error.stackTrace}');
      String message = 'Couldn\'t add user test';
      return message;
    } catch (e) {
      return 'Couldn\'t add user failed';
    }
  }
}
