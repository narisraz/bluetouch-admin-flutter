import 'package:bluetouch_admin/company/models/saep.dart';
import 'package:bluetouch_admin/company/repository/saep_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SaepFirestoreRepository extends SaepRepository {
  final FirebaseFirestore _firestore;

  SaepFirestoreRepository(this._firestore);

  @override
  Future<void> save(Saep saep) {
    return _firestore.collection("saep").add(saep.toJson());
  }
}
