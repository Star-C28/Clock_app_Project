import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authservice {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> signup(String name, String email, String password) async {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);

    await firestore.collection('users').doc(userCredential.user!.uid).set({
      'name':name,
      'email':email,
      'password':password,
    });
  }

Future<User?>login(String email,String password)async{
  UserCredential userCredential= await auth.signInWithEmailAndPassword(email:email , password: password);
  return userCredential.user;
}
Future<void>signout()async{
  await auth.signOut();
}
}