import 'package:bluetouch_admin/auth/models/auth_state.dart';
import 'package:bluetouch_admin/auth/models/auth_status.dart';
import 'package:bluetouch_admin/auth/providers/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

@riverpod
class Auth extends _$Auth {
  @override
  AuthState build() => AuthState();

  Future<void> login({required String email, required String password}) {
    return ref
        .read(authRepositoryProvider)
        .login(email, password)
        .then((value) {
      if (value != null) {
        setState(AuthState(status: AuthStatus.success, currentUser: value));
      } else {
        setState(AuthState(status: AuthStatus.failed));
      }
    });
  }

  FutureOr<void> setState(AuthState state) {
    this.state = state;
  }

  FutureOr<void> logout() {
    ref.read(authRepositoryProvider).logout();
    setState(AuthState());
  }
}
