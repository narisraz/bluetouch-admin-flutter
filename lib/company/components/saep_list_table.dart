import 'package:bluetouch_admin/company/components/button_add_saep.dart';
import 'package:bluetouch_admin/company/models/saep.dart';
import 'package:bluetouch_admin/company/models/saep_type.dart';
import 'package:bluetouch_admin/company/models/water_resource.dart';
import 'package:bluetouch_admin/company/providers/company_service.dart';
import 'package:bluetouch_admin/company/providers/saep_service.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SaepListTable extends ConsumerWidget {
  const SaepListTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final companyId = ref.read(companyServiceProvider).selectedId;
    final saepStream =
        ref.read(saepServiceProvider.notifier).getAllByCompanyId(companyId!);
    return StreamBuilder(
        stream: saepStream,
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
                        DataColumn(label: Text("Type")),
                        DataColumn(label: Text("Ressource en eau")),
                        DataColumn(label: Text("Nombre de population")),
                        DataColumn(label: Text("Réservoir (m³)")),
                      ],
                      source: SaepDataSource(data: snapshot.data!.toList()),
                      header: const Text("Liste des SAEP"),
                      actions: [ButtonAddSaep(companyId: companyId)],
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

class SaepDataSource extends DataTableSource {
  final List<Saep> data;

  SaepDataSource({required this.data});

  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(data[index].name)),
      DataCell(Text(data[index].saepType.data.label)),
      DataCell(Text(data[index].waterResource.data.label)),
      DataCell(Text(data[index].populationSize.toString())),
      DataCell(Text(data[index].reservoirSize.toString())),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
