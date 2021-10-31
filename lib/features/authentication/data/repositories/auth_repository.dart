import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:socially/features/authentication/data/config/paths.dart';
import 'package:socially/features/authentication/data/models/failure_model.dart';
import 'repositories.dart';

class AuthRepository extends BaseAuthRepository {
  final FirebaseFirestore _firebaseFirestore;
  final auth.FirebaseAuth _fireBaseAuth;

  AuthRepository({
    FirebaseFirestore? firebaseFirestore,
    auth.FirebaseAuth? firebaseAuth,
  })  : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance,
        _fireBaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance;

  @override
  Stream<auth.User?> get user => _fireBaseAuth.userChanges();

  @override
  Future<auth.User> signUpWithEmailAndPassword({
    @required String? username,
    @required String? email,
    @required String? password,
  }) async {
    try {
      final credential = await _fireBaseAuth.createUserWithEmailAndPassword(
          email: email!, password: password!);
      final user = credential.user;
      _firebaseFirestore.collection(Paths.users).doc(user!.uid).set({
        'user': username,
        'email': email,
        'followers': 0,
        'following': 0,
      });
      return user;
    } on auth.FirebaseAuthException catch (error) {
      throw Failure(code: error.code, message: error.message!);
    } on PlatformException catch (error) {
      throw Failure(code: error.code, message: error.message!);
    }
  }

  @override
  Future<auth.User> logInWithEmailAndPassword({
    @required String? email,
    @required String? password,
  }) async {
    try {
      final credential = await _fireBaseAuth.signInWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      return credential.user!;
    } on auth.FirebaseAuthException catch (error) {
      throw Failure(code: error.code, message: error.message!);
    } on PlatformException catch (error) {
      throw Failure(code: error.code, message: error.message!);
    }
  }

  @override
  Future<void> logOut() async {
    await _fireBaseAuth.signOut();
  }
}
