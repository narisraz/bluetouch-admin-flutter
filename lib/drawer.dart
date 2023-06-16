import 'package:bluetouch_admin/auth/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView(
              children: [
                DrawerHeader(
                  child: Center(child: Text(authState.currentUser!.email)),
                ),
                const ListTile(
                  leading: Icon(Icons.dashboard),
                  title: Text("Tableau de bord"),
                ),
                const ListTile(
                  leading: Icon(Icons.person),
                  title: Text("Compagnies"),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Se déconnecter"),
            onTap: () {
              ref.read(authProvider.notifier).logout();
            },
          ),
        ],
      ),
    );
  }
}
