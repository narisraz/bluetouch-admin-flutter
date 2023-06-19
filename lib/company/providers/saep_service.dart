import 'package:bluetouch_admin/company/models/saep.dart';
import 'package:bluetouch_admin/company/models/saep_state.dart';
import 'package:bluetouch_admin/company/providers/saep_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'saep_service.g.dart';

@riverpod
class SaepService extends _$SaepService {
  @override
  SaepState build() => SaepState();

  Future<void> save(Saep saep) {
    return ref.read(saepRepositoryProvider).save(saep);
  }
}