import 'package:bluetouch_admin/company/repository/company_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CompanyFirestoreRepository extends CompanyRepository {
  final FirebaseFirestore _firebaseFirestore;

  CompanyFirestoreRepository(this._firebaseFirestore);
}
