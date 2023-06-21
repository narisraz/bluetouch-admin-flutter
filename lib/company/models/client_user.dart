import 'package:bluetouch_admin/company/models/client_user_role.dart';

class ClientUser {
  final String name;
  final String firstName;
  final ClientUserRole role;
  final String companyId;
  final List<String?> saepIdList;
  final String userName;
  final String? password;

  ClientUser(
      {required this.name,
      required this.firstName,
      required this.userName,
      this.password,
      required this.role,
      required this.companyId,
      required this.saepIdList});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'firstName': firstName,
      'userName': userName,
      'role': role.name,
      'companyId': companyId,
      'saepList': saepIdList
    };
  }

  static ClientUser fromJson(Map<String, dynamic> data) {
    return ClientUser(
        name: data['name'],
        firstName: data["firstName"],
        userName: data["userName"],
        role: ClientUserRole.values.byName(data["role"]),
        companyId: data["companyId"],
        saepIdList: [...data["saepList"]]);
  }
}
