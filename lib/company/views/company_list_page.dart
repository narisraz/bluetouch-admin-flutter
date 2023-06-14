import 'package:bluetouch_admin/company/bloc/company_bloc.dart';
import 'package:bluetouch_admin/company/components/button_add_company.dart';
import 'package:bluetouch_admin/company/models/company.dart';
import 'package:bluetouch_admin/company/repository/company_repository.dart';
import 'package:bluetouch_admin/infrastructure/company_firestore_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompanyListPage extends StatelessWidget {
  const CompanyListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) =>
          CompanyFirestoreRepository(FirebaseFirestore.instance),
      child: Scrollbar(
        child: ListView(
          children: [
            BlocProvider(
              create: (context) => CompanyBloc(
                  companyRepository: context.read<CompanyRepository>())
                ..add(CompanyEventGetAll()),
              child: BlocBuilder<CompanyBloc, CompanyState>(
                builder: (context, state) {
                  switch (state.status) {
                    case CompanyStatus.initial:
                      return const Center(child: CircularProgressIndicator());
                    case CompanyStatus.fail:
                      return const Center(
                          child: Text(
                              'Erreur lors de la récupération des entreprises'));
                    case CompanyStatus.added:
                    case CompanyStatus.success:
                      return Scrollbar(
                          child: PaginatedDataTable(
                        showFirstLastButtons: true,
                        primary: true,
                        source: CompanyListDataSource(
                            companies: state.companies ?? []),
                        header: const Text('Liste des entreprises'),
                        rowsPerPage: 10,
                        actions: const [ButtonAddCompany()],
                        columns: const [
                          DataColumn(label: Text("Nom de l'entreprise"))
                        ],
                      ));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CompanyListDataSource extends DataTableSource {
  final List<Company> companies;

  CompanyListDataSource({required this.companies});

  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [DataCell(Text(companies[index].name))]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => companies.length;

  @override
  int get selectedRowCount => 0;
}
