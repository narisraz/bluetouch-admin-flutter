import 'package:bluetouch_admin/company/models/client_user.dart';
import 'package:bluetouch_admin/company/models/client_user_role.dart';
import 'package:bluetouch_admin/company/models/client_user_status.dart';
import 'package:bluetouch_admin/company/providers/client_user_service.dart';
import 'package:bluetouch_admin/company/providers/company_service.dart';
import 'package:bluetouch_admin/company/providers/saep_service.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class ClientUserFormDialog extends ConsumerWidget {
  const ClientUserFormDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final companyId = ref.read(companyServiceProvider).selectedId;
    final formKey = GlobalKey<FormState>();

    final nameController = TextEditingController();
    final firstNameController = TextEditingController();
    final userNameController = TextEditingController();
    final passwordController = TextEditingController();
    var clientUserRole = ClientUserRole.gestionnaire.name;
    final saepListStream =
        ref.watch(saepServiceProvider.notifier).getAllByCompanyId(companyId!);
    List<String?> selectedSaepList = [];

    ref.listen(clientUserServiceProvider, (previous, next) {
      final status = next.status;
      if (status == ClientUserStatus.registrationFail) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            showCloseIcon: true,
            content: Text("Email déjà utilisé par un autre utilisateur")));
      }
    });

    return AlertDialog(
      title: const Text("Création utilisateur"),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 250),
        child: Form(
          key: formKey,
          child: Wrap(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Nom"),
                controller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Ce champ est obligatoire";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Prénom"),
                controller: firstNameController,
              ),
              DropdownButtonFormField(
                items: ClientUserRole.values.map((e) {
                  return DropdownMenuItem(
                    value: e.name,
                    child: Text(e.data.label),
                  );
                }).toList(),
                onChanged: (value) {
                  clientUserRole = value!;
                },
                value: clientUserRole,
                decoration: const InputDecoration(labelText: "Rôle"),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Email"),
                controller: userNameController,
                validator: (value) =>
                    EmailValidator.validate(value!) ? null : "Email non valide",
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Mot de passe"),
                controller: passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Ce champ est obligatoire";
                  }
                  if (value.length < 6) {
                    return "Le mot de passe doit contenir au moins 6 caractères";
                  }
                  return null;
                },
              ),
              StreamBuilder(
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.connectionState == ConnectionState.active) {
                    return MultiSelectDialogField(
                      selectedColor: Theme.of(context).colorScheme.primary,
                      dialogWidth: 200,
                      dialogHeight: 300,
                      items: snapshot.data!
                          .map((e) => MultiSelectItem(e.id, e.name))
                          .toList(),
                      listType: MultiSelectListType.LIST,
                      onConfirm: (values) {
                        selectedSaepList = values;
                      },
                      title: const Text("Choisissez les SAEP concernés"),
                      buttonText: const Text("SAEP"),
                      cancelText: const Text("Annuler"),
                      confirmText: const Text("Ok"),
                    );
                  }
                  return const Center();
                },
                stream: saepListStream,
              )
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
            onPressed: () async {
              if (formKey.currentState?.validate() == true) {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return const Center(child: CircularProgressIndicator());
                    });
                final registerState = await ref
                    .read(clientUserServiceProvider.notifier)
                    .register(ClientUser(
                        name: nameController.text,
                        firstName: firstNameController.text,
                        userName: userNameController.text,
                        password: passwordController.text,
                        role: ClientUserRole.values.byName(clientUserRole),
                        companyId: companyId,
                        saepIdList: selectedSaepList));
                if (registerState.status == ClientUserStatus.registered &&
                    context.mounted) {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                }
              }
            },
            child: const Text("Valider")),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Annuler")),
      ],
    );
  }
}
