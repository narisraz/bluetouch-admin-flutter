import 'package:bluetouch_admin/company/models/client_user.dart';
import 'package:bluetouch_admin/company/models/client_user_state.dart';
import 'package:bluetouch_admin/company/models/client_user_status.dart';
import 'package:bluetouch_admin/company/providers/client_user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'client_user_service.g.dart';

@riverpod
class ClientUserService extends _$ClientUserService {
  @override
  ClientUserState build() => ClientUserState();

  FutureOr<ClientUserState> register(ClientUser clientUser) async {
    try {
      state = ClientUserState(status: ClientUserStatus.waiting);
      final userId =
          await ref.read(clientUserRepositoryProvider).save(clientUser);
      if (userId == null) {
        state = ClientUserState(status: ClientUserStatus.registrationFail);
      } else {
        state = ClientUserState(status: ClientUserStatus.registered);
      }
      return state;
    } catch (e) {
      state = ClientUserState(status: ClientUserStatus.registrationFail);
      return state;
    }
  }

  Stream<int> countByCompany(String companyId) {
    return ref.read(clientUserRepositoryProvider).countByCompany(companyId);
  }
}
