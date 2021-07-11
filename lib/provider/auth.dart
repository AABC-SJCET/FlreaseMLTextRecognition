import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

Future createAccount({required String email, required String password}) async {
  try {
    await Firebase.initializeApp();
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    print(userCredential.user!.uid);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      throw ('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      throw ('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
    throw ("An error occured");
  }
}

Future signInToAcc({required String email, required String password}) async {
  print(password);
  try {
    await Firebase.initializeApp();
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    print(userCredential.user!.uid);
  } on FirebaseAuthException catch (e) {
    print(e.code);
    if (e.code == 'user-not-found') {
      throw ('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      throw ('Wrong password provided for that user.');
    }
  } catch (e) {
    throw ("An error occured");
  }
}
