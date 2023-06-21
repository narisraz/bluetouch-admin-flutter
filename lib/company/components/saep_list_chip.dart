import 'package:bluetouch_admin/company/providers/saep_service.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SaepListChip extends ConsumerWidget {
  final List<String?> saepIds;

  const SaepListChip({super.key, required this.saepIds});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var stream = ref.watch(saepServiceProvider.notifier).getByIds(saepIds);
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.connectionState == ConnectionState.active) {
          return Wrap(
            spacing: 8,
            children: snapshot.data!.map((saep) {
              return Chip(label: Text(saep.name));
            }).toList(),
          );
        }
        return const Center();
      },
    );
  }
}
