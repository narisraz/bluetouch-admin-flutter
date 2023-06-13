import 'package:bluetouch_admin/auth/models/auth_user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("AuthUser from json", () {
    final json = {'uid': 'someid', 'email': 'email@mail.com', 'role': 'admin'};

    final authUser = AuthUser.fromJson(json);

    expect(authUser.role, AuthUserRole.admin);
    expect(authUser.id, 'someid');
    expect(authUser.email, 'email@mail.com');
  });
}
