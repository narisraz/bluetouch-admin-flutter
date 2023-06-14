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
}
