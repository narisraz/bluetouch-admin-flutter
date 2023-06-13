import 'package:bluetouch_admin/auth/models/auth_user.dart';
import 'package:bluetouch_admin/auth/repository/auth_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthFirebaseProvider extends AuthProvider {
  late final FirebaseAuth _firebaseAuth;
  late final FirebaseFirestore _firebaseFirestore;

  AuthFirebaseProvider() {
    _firebaseAuth = FirebaseAuth.instance;
    _firebaseFirestore = FirebaseFirestore.instance;
  }

  @override
  Future<AuthUser?> login(String email, String password) async {
    try {
      var userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      var user = userCredential.user;
      if (user != null) {
        try {
          var userDocument = await _firebaseFirestore
              .collection("users")
              .where("uid", isEqualTo: user.uid)
              .get();
          final AuthUser authUser =
              AuthUser.fromJson(userDocument.docs.first.data());
          if (authUser.role == AuthUserRole.admin) {
            return authUser;
          }
        } catch (e) {
          await logout();
          return Future.value();
        }
      }
      await logout();
      return Future.value();
    } catch (e) {
      return Future.value();
    }
  }

  @override
  Future<void> logout() {
    return _firebaseAuth.signOut();
  }

  @override
  Future<AuthUser?> getCurrentLoggedInUser() async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      var userDocument = await _firebaseFirestore
          .collection("users")
          .where("uid", isEqualTo: user.uid)
          .get();
      return AuthUser.fromJson(userDocument.docs.first.data());
    }
    return Future.value();
  }
}
