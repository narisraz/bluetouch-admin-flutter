import 'package:bluetouch_admin/company/bloc/company_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompanyFormDialog extends StatelessWidget {
  const CompanyFormDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    var nameController = TextEditingController();
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
      content: Form(
          key: formKey,
          child: Wrap(
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Ce champ est obligatoire";
                  }
                  return null;
                },
                onFieldSubmitted: (value) {
                  if (value.isNotEmpty) {
                    addCompany();
                  }
                },
                controller: nameController,
                decoration:
                    const InputDecoration(label: Text("Nom de l'entreprise")),
              ),
            ],
          )),
      actions: [
        ElevatedButton(onPressed: addCompany, child: const Text("Valider")),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Annuler")),
      ],
    );
  }
}
