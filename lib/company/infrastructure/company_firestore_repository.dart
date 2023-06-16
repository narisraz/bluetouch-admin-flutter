import 'package:bluetouch_admin/company/models/company.dart';
import 'package:bluetouch_admin/company/repository/company_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CompanyFirestoreRepository extends CompanyRepository {
  final FirebaseFirestore _firebaseFirestore;

  CompanyFirestoreRepository(this._firebaseFirestore);

  @override
  Future<void> add(Company company) {
    try {
      return _firebaseFirestore
          .collection("companies")
          .add({'name': company.name});
    } catch (e) {
      return Future.value();
    }
  }

  @override
  Stream<Iterable<Company>> getAll() {
    return _firebaseFirestore
        .collection("companies")
        .orderBy('name')
        .snapshots()
        .map((event) => event.docs.map(_addId));
  }

  Company _addId(e) {
    Map<String, dynamic> data = e.data();
    data.putIfAbsent('id', () => e.id);
    return Company.fromJson(e.data());
  }
}
