enum ClientUserRole { gestionnaire, caissier, releveur }

class ClientUserRoleData {
  final String label;

  ClientUserRoleData(this.label);
}

extension UserRoleExtension on ClientUserRole {
  ClientUserRoleData get data {
    switch (this) {
      case ClientUserRole.caissier:
        return ClientUserRoleData("Caissier");
      case ClientUserRole.gestionnaire:
        return ClientUserRoleData("Gestionnaire");
      case ClientUserRole.releveur:
        return ClientUserRoleData("Releveur");
    }
  }
}
