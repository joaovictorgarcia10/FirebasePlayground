import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_playground/firebase_auth/auth_interface.dart';

class CustomFirebaseAuth implements AuthInterface {
  late FirebaseAuth _firebaseAuth;

  CustomFirebaseAuth._internal(this._firebaseAuth);

  static final CustomFirebaseAuth _singleton =
      CustomFirebaseAuth._internal(FirebaseAuth.instance);

  factory CustomFirebaseAuth() => _singleton;

  @override
  Future<bool> doLogin(
      {required String email, required String password}) async {
    try {
      var result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return (result.user != null) ? true : false;
    } on FirebaseAuthException catch (_) {
      return false;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> registerUser(
      {required String email, required String password}) async {
    try {
      var result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      return (result.user != null) ? true : false;
    } on FirebaseAuthException catch (_) {
      return false;
    } catch (e) {
      return false;
    }
  }

  @override
  bool isValidInputs({required String email, required String password}) =>
      email.isNotEmpty && password.length >= 6;
}
