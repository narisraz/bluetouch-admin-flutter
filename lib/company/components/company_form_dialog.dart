import 'package:bluetouch_admin/company/models/company.dart';
import 'package:bluetouch_admin/company/providers/company_service.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CompanyFormDialog extends ConsumerWidget {
  const CompanyFormDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    var nameController = TextEditingController();

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
                  if (formKey.currentState?.validate() == true) {
                    ref
                        .read(companyServiceProvider.notifier)
                        .save(Company(name: nameController.text));
                    Navigator.of(context).pop();
                  }
                },
                controller: nameController,
                decoration:
                    const InputDecoration(label: Text("Nom de l'entreprise")),
              ),
            ],
          )),
      actions: [
        ElevatedButton(
            onPressed: () {
              if (formKey.currentState?.validate() == true) {
                ref
                    .read(companyServiceProvider.notifier)
                    .save(Company(name: nameController.text));
                Navigator.of(context).pop();
              }
            },
            child: const Text("Valider")),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Annuler")),
      ],
    );
  }
}
