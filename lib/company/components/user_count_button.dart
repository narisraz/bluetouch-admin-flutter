import 'package:bluetouch_admin/company/components/user_list_table.dart';
import 'package:bluetouch_admin/company/providers/company_service.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserCountButton extends ConsumerWidget {
  final int value;
  final String companyId;

  const UserCountButton(
      {super.key, required this.companyId, required this.value});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
        onPressed: () {
          ref.read(companyServiceProvider.notifier).setSelectedId(companyId);
          showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  content: const ClientUserListTable(),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Fermer"))
                  ],
                );
              });
        },
        child: Text(value.toString()));
  }
}
