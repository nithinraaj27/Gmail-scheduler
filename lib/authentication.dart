import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

FirebaseAuth auth = FirebaseAuth.instance;
final googleSignIn = GoogleSignIn();

Future googlesignIn() async
{
  GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

  if(googleSignInAccount != null)
  {
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken
    );

    UserCredential result = await auth.signInWithCredential(credential);

    User user = await auth.currentUser;
    print(user.uid);

    return Future.value(true);
  }
}

Future signIn(String email, String password) async{
  try{
    UserCredential result = await auth.signInWithEmailAndPassword(email: email, password: password);
    //User user = result.user;

    return Future.value(true);
  }
  catch(e)
  {
    print("error by u in signin");
  }
}

Future signUp(String email, String password) async{
  try{
    UserCredential result = await auth.createUserWithEmailAndPassword(email: email, password: password);
    //User user = result.user;

    return Future.value(true);
  }
  catch(e)
  {
    print("error by u in signup");
  }
}

Future signoutUser() async {

  User user = await auth.currentUser;

  if(user.providerData[1].providerId == 'google.com')
  {
    await googleSignIn.disconnect();
  }
  await auth.signOut();
}