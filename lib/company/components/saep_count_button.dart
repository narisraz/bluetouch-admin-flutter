import 'package:bluetouch_admin/company/components/saep_list_table.dart';
import 'package:bluetouch_admin/company/providers/company_service.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SaepCountButton extends ConsumerWidget {
  final int value;
  final String companyId;

  const SaepCountButton(
      {super.key, required this.value, required this.companyId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
        onPressed: () {
          ref.read(companyServiceProvider.notifier).setSelectedId(companyId);
          showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  content: const SaepListTable(),
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
