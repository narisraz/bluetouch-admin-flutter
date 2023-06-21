import 'package:bluetouch_admin/company/models/client_user.dart';

abstract class ClientUserRepository {
  Future<String?> save(ClientUser clientUser);

  Stream<int> countByCompany(String companyId);

  Stream<Iterable<ClientUser>> getAllByCompany(String companyId);
}
