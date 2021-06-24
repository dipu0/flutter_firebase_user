import 'package:firebase_auth/firebase_auth.dart';

class AuthClass{

  FirebaseAuth auth = FirebaseAuth.instance;
  //Created Account
Future<String> createAccount({String email, String password}) async{

  try {
    await auth.createUserWithEmailAndPassword(
        email:email,
        password: password
    );
    return "Account Created";
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      return 'The password provided is too weak.';
    } else if (e.code == 'email-already-in-use') {
      return 'The account already exists for that email.';
    }
  } catch (e) {
    return 'Error Occurred';
  }
}
//Sign in user
  Future<String> signIn({String email, String password}) async {
    try {
     await auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
     return 'Welcome';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
    }
  }

//Reset Password
  Future<String> resetPassword({String email}) async {
    try {
      await auth.sendPasswordResetEmail(
          email: email,
      );
      return 'Email Send';
    }catch(r){
      return 'Error Occurred';
    }
  }

//sign out user
void signOut(){
  auth.signOut();
}
}