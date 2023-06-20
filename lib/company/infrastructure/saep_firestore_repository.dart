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

  @override
  Stream<int> countByCompany(String companyId) {
    return _firestore
        .collection("saep")
        .where("companyId", isEqualTo: companyId)
        .snapshots()
        .map((event) => event.size);
  }

  @override
  Stream<Iterable<Saep>> getAllByCompany(String companyId) {
    return _firestore
        .collection("saep")
        .where("companyId", isEqualTo: companyId)
        .snapshots()
        .map((event) => event.docs.map((_dataWithId)));
  }

  Saep _dataWithId(e) {
    Map<String, dynamic> data = e.data();
    data.putIfAbsent("id", () => e.id);
    return Saep.fromJson(data);
  }
}
