import 'package:bluetouch_admin/company/components/button_add_company.dart';
import 'package:bluetouch_admin/company/components/button_add_saep.dart';
import 'package:bluetouch_admin/company/models/company.dart';
import 'package:bluetouch_admin/company/providers/company_service.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CompanyListPage extends ConsumerWidget {
  const CompanyListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var companies = ref.watch(companyServiceProvider.notifier).getAll();
    return StreamBuilder(
      stream: companies,
      builder: (context, snapshot) {
        return ListView(
          children: [
            Builder(builder: (context) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                case ConnectionState.none:
                case ConnectionState.active:
                case ConnectionState.done:
                  return Scrollbar(
                      child: PaginatedDataTable(
                    showFirstLastButtons: true,
                    primary: true,
                    source: CompanyListDataSource(
                        companies: snapshot.data?.toList() ?? []),
                    header: const Text('Liste des entreprises'),
                    rowsPerPage: 10,
                    actions: const [ButtonAddCompany()],
                    columns: const [
                      DataColumn(label: Text("Nom de l'entreprise")),
                      DataColumn(label: Text("Actions")),
                    ],
                  ));
              }
            })
          ],
        );
      },
    );
  }
}

class CompanyListDataSource extends DataTableSource {
  final List<Company> companies;

  CompanyListDataSource({required this.companies});

  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(companies[index].name)),
      DataCell(ButtonAddSaep(
        companyId: companies[index].id!,
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => companies.length;

  @override
  int get selectedRowCount => 0;
}
