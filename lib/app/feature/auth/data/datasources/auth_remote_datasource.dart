import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:newspaper_app/app/feature/auth/domain/entities/user_entity.dart';

abstract class AuthRemoteDataSource {
  Future<void> signInWithGoogle();
  Future<void> signInWithEmail(String email, String password);
  Future<void> registerWithEmail(String email, String password);
  Future<void> updatePassword( String password);
  bool isUserLoggedIn();
  Future<void> signOut();
  UserEntity getUserInfo();

}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _auth ;
  final GoogleSignIn _googleSignIn ;
  AuthRemoteDataSourceImpl(this._auth, this._googleSignIn);
  @override
  Future<void> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) throw Exception('Google Sign-In failed');
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _auth.signInWithCredential(credential);
  }

  @override
  Future<void> signInWithEmail(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> registerWithEmail(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(email: email, password: password);
  }
  @override
  bool isUserLoggedIn() {
    return _auth.currentUser != null;
  }
  @override
  Future<void> signOut() async {
    await _auth.signOut(); // Sign out from Firebase Auth
    await _googleSignIn.signOut(); // Disconnect from Google Sign-In
  }
  @override
  UserEntity getUserInfo() {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User is not logged in');
    }
    return UserEntity(
      uid: user.uid,
      email: user.email ?? '',
      displayName: user.displayName,
      photoURL: user.photoURL,
    );
  }

  @override
  Future<void> updatePassword(String newPassword) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User is not logged in');
    }

    try {
      if (user.providerData.any((info) => info.providerId == 'password')) {
        final credential = EmailAuthProvider.credential(email: user.email!, password: newPassword);
        await user.reauthenticateWithCredential(credential);
      } else {
        // Link the email/password credential for the first time
        final credential = EmailAuthProvider.credential(email: user.email!, password: newPassword);
        await user.linkWithCredential(credential);
      }

      // Update the password
      await user.updatePassword(newPassword);
    } catch (e) {
      throw Exception('Failed to update password: $e');
    }
  }
}