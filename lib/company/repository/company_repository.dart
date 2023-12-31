import 'package:bluetouch_admin/company/models/company.dart';

abstract class CompanyRepository {
  Future<void> add(Company company);

  Stream<Iterable<Company>> getAll();
}
