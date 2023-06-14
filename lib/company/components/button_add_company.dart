import 'package:bluetouch_admin/company/bloc/company_bloc.dart';
import 'package:bluetouch_admin/company/repository/company_repository.dart';
import 'package:bluetouch_admin/company/views/company_form_page.dart';
import 'package:bluetouch_admin/infrastructure/company_firestore_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonAddCompany extends StatelessWidget {
  const ButtonAddCompany({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.add),
      label: const Text("Nouveau"),
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              final formKey = GlobalKey<FormState>();

              var nameController = TextEditingController();

              return RepositoryProvider<CompanyRepository>(
                create: (context) =>
                    CompanyFirestoreRepository(FirebaseFirestore.instance),
                child: BlocProvider(
                  create: (context) => CompanyBloc(
                      companyRepository: context.read<CompanyRepository>()),
                  child: BlocBuilder<CompanyBloc, CompanyState>(
                    builder: (context, state) {
                      addCompany() {
                        if (formKey.currentState!.validate()) {
                          context
                              .read<CompanyBloc>()
                              .add(CompanyEventAdd(name: nameController.text));
                          Navigator.of(context).pop();
                        }
                      }

                      return AlertDialog(
                        title: const Text("Création d'entreprise"),
                        content: CompanyNewPage(
                            nameController: nameController,
                            formKey: formKey,
                            submitEvent: addCompany),
                        actions: [
                          ElevatedButton(
                              onPressed: addCompany,
                              child: const Text("Valider")),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("Annuler")),
                        ],
                      );
                    },
                  ),
                ),
              );
            });
      },
    );
  }
}
