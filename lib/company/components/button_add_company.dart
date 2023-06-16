import 'package:bluetouch_admin/company/components/company_form_dialog.dart';
import 'package:flutter/material.dart';

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
            builder: (_) {
              return const CompanyFormDialog();
            });
      },
    );
  }
}
