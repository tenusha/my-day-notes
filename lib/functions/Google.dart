import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;

Future<FirebaseUser> handleGoogleSignIn() async {   // hold the instance of the authenticated user
  FirebaseUser user;   // flag to check whether we're signed in already
  bool isSignedIn = await _googleSignIn.isSignedIn();   if (isSignedIn) {
    // if so, return the current user
    user = await _auth.currentUser();
  }   else {
    final GoogleSignInAccount googleUser =
    await _googleSignIn.signIn();      final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;      // get the credentials to (access / id token)
    // to sign in via Firebase Authentication
    final AuthCredential credential =
    GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken
    );      user = (await _auth.signInWithCredential(credential)).user;
  }

  return user;
}