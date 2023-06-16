import 'package:bluetouch_admin/auth/models/auth_status.dart';
import 'package:bluetouch_admin/auth/models/auth_user.dart';

class AuthState {
  final AuthStatus status;
  final AuthUser? currentUser;

  AuthState({this.status = AuthStatus.initial, this.currentUser});
}
