import 'package:bluetouch_admin/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView(
              children: [
                DrawerHeader(
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return Center(
                          child: Text(state.authenticatedUser!.email));
                    },
                  ),
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
              context.read<AuthBloc>().add(AuthEventLogout());
            },
          ),
        ],
      ),
    );
  }
}
