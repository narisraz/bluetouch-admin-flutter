import 'package:bluetouch_admin/company/models/client_user.dart';
import 'package:bluetouch_admin/company/repository/client_user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ClientUserFirestoreRepository extends ClientUserRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  ClientUserFirestoreRepository(this._firestore, this._firebaseAuth);

  @override
  Future<String?> save(ClientUser clientUser) async {
    final createUserWithEmailAndPassword =
        await _firebaseAuth.createUserWithEmailAndPassword(
            email: clientUser.userName, password: clientUser.password!);
    final user = createUserWithEmailAndPassword.user;
    if (user != null) {
      final newUser =
          await _firestore.collection("users").add(clientUser.toJson());
      return newUser.id;
    }
    return null;
  }
}
