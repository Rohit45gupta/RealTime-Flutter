import 'dart:developer';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:realtime_db/model/user_model.dart';

class AuthService {
  final auth = FirebaseAuth.instance;

  Future<User?> createUserWithEmail(String email, String password) async {
    try {
      final cred = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } catch (e) {
      log('Something went wrong $e');
    }
    return null;
  }

  Future<User?> signInUserWithEmail(String email, String password) async {
    try {
      final cred = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } catch (e) {
      log('Something went wrong $e');
    }
    return null;
  }

  Future<void> logOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      log('Something went wrogn!');
    }
  }
}

class Controller extends GetxController {
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref('EmployeeInfo');

  Future<void> addData(UserModel userData) async {
    try {
      await databaseReference
          .child(userData.userId.toString())
          .set(userData.toMap());
      Fluttertoast.showToast(msg: 'save userData');
    } catch (e) {
      log('Something went wrong $e');
      Fluttertoast.showToast(msg: 'Error $e');
    }
  }

  Future<void> updateUser(UserModel userModel) async {
    final id = userModel.userId;
    try {
      databaseReference.child(id).update(userModel.toMap());
      Fluttertoast.showToast(msg: 'User updated Successfully');
    } catch (e) {
      Fluttertoast.showToast(msg: '$e');
    }
  }


  Future<void> deleteData(String id) async {
    final data = await databaseReference.child(id).get();
    try {
      if (data.exists) {
        databaseReference.child(id).remove();
        Fluttertoast.showToast(msg: 'User deleted successfully');
      } else {
        Fluttertoast.showToast(msg: 'User id doesn`t exist');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: '$e');
    }
  }
}
