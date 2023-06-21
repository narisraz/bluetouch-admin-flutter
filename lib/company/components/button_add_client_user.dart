import 'package:bluetouch_admin/company/components/client_user_form_dialog.dart';
import 'package:bluetouch_admin/company/providers/company_service.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ButtonAddClientUser extends ConsumerWidget {
  final String companyId;

  const ButtonAddClientUser({super.key, required this.companyId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Tooltip(
      message: "Ajouter un utilisateur",
      child: IconButton(
        icon: const Icon(Icons.person),
        onPressed: () {
          ref.read(companyServiceProvider.notifier).setSelectedId(companyId);
          showDialog(
              context: context,
              builder: (_) {
                return const ClientUserFormDialog();
              });
        },
      ),
    );
  }
}
