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

  Future<void> save(Company company) {
    return ref.read(companyRepositoryProvider).add(company);
  }

  void setSelectedId(String id) {
    state = CompanyState(
        status: state.status, companies: state.companies, selectedId: id);
  }
}
