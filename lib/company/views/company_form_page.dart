import 'package:flutter/material.dart';

class CompanyNewPage extends StatelessWidget {
  final TextEditingController nameController;
  final GlobalKey<FormState> formKey;
  final Function() submitEvent;

  const CompanyNewPage(
      {super.key,
      required this.nameController,
      required this.formKey,
      required this.submitEvent});

  @override
  Widget build(BuildContext context) {
    return Form(
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
                  submitEvent();
                }
              },
              controller: nameController,
              decoration:
                  const InputDecoration(label: Text("Nom de l'entreprise")),
            ),
          ],
        ));
  }
}
