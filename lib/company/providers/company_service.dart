import 'package:bluetouch_admin/company/models/company.dart';
import 'package:bluetouch_admin/company/models/company_state.dart';
import 'package:bluetouch_admin/company/providers/company_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'company_service.g.dart';

@riverpod
class CompanyService extends _$CompanyService {
  @override
  CompanyState build() => CompanyState();

  Stream<Iterable<Company>> getAll() {
    return ref.read(companyRepositoryProvider).getAll();
  }
}
