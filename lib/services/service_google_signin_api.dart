import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInApi {
  static final _googleSignIn = GoogleSignIn();

  static Future<GoogleSignInAccount?> signIn() {
    return _googleSignIn.signIn();
  }

  static Future<GoogleSignInAccount?> checkSignIn() {
    return _googleSignIn.signInSilently();
  }

  static GoogleSignInAccount? getUserDetails() {
    return _googleSignIn.currentUser;
  }

  static Future<GoogleSignInAccount?> signOut() {
    return _googleSignIn.signOut();
  }
}
