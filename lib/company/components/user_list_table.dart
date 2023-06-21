import 'package:bluetouch_admin/company/components/button_add_client_user.dart';
import 'package:bluetouch_admin/company/components/saep_list_chip.dart';
import 'package:bluetouch_admin/company/models/client_user.dart';
import 'package:bluetouch_admin/company/models/client_user_role.dart';
import 'package:bluetouch_admin/company/providers/client_user_service.dart';
import 'package:bluetouch_admin/company/providers/company_service.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ClientUserListTable extends ConsumerWidget {
  const ClientUserListTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final companyId = ref.read(companyServiceProvider).selectedId;
    final clientUserStream = ref
        .read(clientUserServiceProvider.notifier)
        .getAllByCompanyId(companyId!);
    return StreamBuilder(
        stream: clientUserStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.connectionState == ConnectionState.active) {
            return SizedBox(
              width: double.maxFinite,
              height: 660,
              child: ListView(
                children: [
                  Scrollbar(
                    child: PaginatedDataTable(
                      primary: true,
                      columns: const [
                        DataColumn(label: Text("Nom")),
                        DataColumn(label: Text("Prénom")),
                        DataColumn(label: Text("Rôle")),
                        DataColumn(label: Text("Email")),
                        DataColumn(label: Text("SAEP")),
                      ],
                      source:
                          ClientUserDataSource(data: snapshot.data!.toList()),
                      header: const Text("Liste des utilisateurs"),
                      actions: [
                        ButtonAddClientUser(
                          companyId: companyId,
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center();
        });
  }
}

class ClientUserDataSource extends DataTableSource {
  final List<ClientUser> data;

  ClientUserDataSource({required this.data});

  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(data[index].name)),
      DataCell(Text(data[index].firstName)),
      DataCell(Text(data[index].role.data.label)),
      DataCell(Text(data[index].userName)),
      DataCell(SaepListChip(
        saepIds: data[index].saepIdList,
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
