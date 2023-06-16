import 'package:bluetouch_admin/company/models/company.dart';
import 'package:bluetouch_admin/company/models/company_status.dart';

class CompanyState {
  final CompanyStatus status;
  final Future<List<Company>>? companies;

  CompanyState({this.status = CompanyStatus.initial, this.companies});
}
