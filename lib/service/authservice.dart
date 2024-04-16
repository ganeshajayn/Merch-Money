import 'package:firebase_auth/firebase_auth.dart';
import 'package:merchmoney/helper/helperfunctions.dart';
import 'package:merchmoney/service/databaseservice.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//login
  Future loginWithUserNameandPassword(String email, String password) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;
      // ignore: unnecessary_null_comparison
      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

//register
  Future registerUserWithEmailandPassword(
    String email,
    String password,
    String fullname,
  ) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user!;

      // ignore: unnecessary_null_comparison
      if (user != null) {
        await DatabaseService(uid: user.uid).savingUserData(email, fullname);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future signOut() async {
    try {
      await HelperFunctions.saveUserLoggedInStatus(false);
      await HelperFunctions.saveUserEmailSf("");
      await HelperFunctions.saveUserNameSf("");
      await firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }
}
