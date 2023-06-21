import 'package:bluetouch_admin/company/components/button_add_client_user.dart';
import 'package:bluetouch_admin/company/components/button_add_company.dart';
import 'package:bluetouch_admin/company/components/button_add_saep.dart';
import 'package:bluetouch_admin/company/components/saep_count_button.dart';
import 'package:bluetouch_admin/company/components/user_count_button.dart';
import 'package:bluetouch_admin/company/models/company.dart';
import 'package:bluetouch_admin/company/providers/client_user_service.dart';
import 'package:bluetouch_admin/company/providers/company_service.dart';
import 'package:bluetouch_admin/company/providers/saep_service.dart';
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
                      DataColumn(label: Text("Nombre de SAEP")),
                      DataColumn(label: Text("Nombre d'utilisateurs")),
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
      DataCell(Consumer(builder: (context, ref, child) {
        final countByCompany = ref
            .read(saepServiceProvider.notifier)
            .countByCompany(companies[index].id!);
        return StreamBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.connectionState == ConnectionState.active &&
                snapshot.data != 0) {
              return SaepCountButton(
                  value: snapshot.data!, companyId: companies[index].id!);
            }
            return const Center();
          },
          stream: countByCompany,
        );
      })),
      DataCell(Consumer(
        builder: (context, ref, child) {
          final countUserByCompany = ref
              .read(clientUserServiceProvider.notifier)
              .countByCompany(companies[index].id!);
          return StreamBuilder(
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.connectionState == ConnectionState.active &&
                  snapshot.data != 0) {
                return UserCountButton(
                    value: snapshot.data!, companyId: companies[index].id!);
              }
              return const Center();
            },
            stream: countUserByCompany,
          );
        },
      )),
      DataCell(Wrap(
        spacing: 8,
        children: [
          ButtonAddSaep(
            companyId: companies[index].id!,
          ),
          ButtonAddClientUser(
            companyId: companies[index].id!,
          )
        ],
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
