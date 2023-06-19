import 'package:bluetouch_admin/company/components/saep_form_dialog.dart';
import 'package:bluetouch_admin/company/providers/company_service.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ButtonAddSaep extends ConsumerWidget {
  final String companyId;

  const ButtonAddSaep({super.key, required this.companyId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Tooltip(
      message: "Ajouter un SAEP",
      child: IconButton(
        icon: const Icon(Icons.add),
        onPressed: () {
          ref.read(companyServiceProvider.notifier).setSelectedId(companyId);
          showDialog(
              context: context,
              builder: (_) {
                return const SaepFormDialog();
              });
        },
      ),
    );
  }
}
