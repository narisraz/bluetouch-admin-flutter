import 'package:bluetouch_admin/company/models/client_user.dart';
import 'package:bluetouch_admin/company/models/client_user_status.dart';

class ClientUserState {
  final ClientUserStatus status;
  final List<ClientUser>? clientUsers;

  ClientUserState({this.status = ClientUserStatus.initial, this.clientUsers});
}
