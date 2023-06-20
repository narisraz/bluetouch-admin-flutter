import 'package:bluetouch_admin/company/models/saep.dart';

abstract class SaepRepository {
  Future<void> save(Saep saep);

  Stream<int> countByCompany(String companyId);

  Stream<Iterable<Saep>> getAllByCompany(String companyId);
}
