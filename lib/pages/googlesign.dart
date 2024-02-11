import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInPage extends StatefulWidget {
  @override
  _GoogleSignInPageState createState() => _GoogleSignInPageState();
}

class _GoogleSignInPageState extends State<GoogleSignInPage> {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Google Sign In')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
              GoogleSignInAuthentication googleAuth =
                  await googleUser!.authentication;
              UserCredential userCredential = await _auth.signInWithCredential(
                GoogleAuthProvider.credential(
                  accessToken: googleAuth.accessToken,
                  idToken: googleAuth.idToken,
                ),
              );
              print('Signed in ${userCredential.user!.uid}');
            } catch (e) {
              print(e);
            }
          },
          child: Text('Google Sign In'),
        ),
      ),
    );
  }
}
