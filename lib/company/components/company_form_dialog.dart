import 'package:flutter/material.dart';

class CompanyFormDialog extends StatelessWidget {
  const CompanyFormDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                  if (value.isNotEmpty) {}
                },
                controller: nameController,
                decoration:
                    const InputDecoration(label: Text("Nom de l'entreprise")),
              ),
            ],
          )),
      actions: [
        ElevatedButton(onPressed: () {}, child: const Text("Valider")),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Annuler")),
      ],
    );
  }
}
