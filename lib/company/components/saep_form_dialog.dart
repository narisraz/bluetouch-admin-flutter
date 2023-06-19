import 'package:bluetouch_admin/company/models/saep.dart';
import 'package:bluetouch_admin/company/models/saep_type.dart';
import 'package:bluetouch_admin/company/models/water_resource.dart';
import 'package:bluetouch_admin/company/providers/company_service.dart';
import 'package:bluetouch_admin/company/providers/saep_service.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SaepFormDialog extends ConsumerWidget {
  const SaepFormDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final companyId = ref.read(companyServiceProvider).selectedId;
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final populationSizeController = TextEditingController();
    final reservoirController = TextEditingController();
    var waterResource = WaterResource.surfaceWater.name;
    var saepType = SaepType.byPumping.name;

    return AlertDialog(
      title: const Text("Création SAEP"),
      content: Form(
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
            DropdownButtonFormField(
              items: SaepType.values.map((e) {
                return DropdownMenuItem(
                  value: e.name,
                  child: Text(e.data.label),
                );
              }).toList(),
              onChanged: (value) {
                saepType = value!;
              },
              value: saepType,
              decoration: const InputDecoration(labelText: "Type"),
            ),
            DropdownButtonFormField(
              items: WaterResource.values.map((e) {
                return DropdownMenuItem(
                  value: e.name,
                  child: Text(e.data.label),
                );
              }).toList(),
              onChanged: (value) {
                waterResource = value!;
              },
              value: waterResource,
              decoration: const InputDecoration(labelText: "Ressource en eau"),
            ),
            TextFormField(
              decoration:
                  const InputDecoration(labelText: "Nombre de population"),
              controller: populationSizeController,
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  suffixText: "m³", labelText: "Réservoir"),
              controller: reservoirController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              if (formKey.currentState?.validate() == true) {
                ref.read(saepServiceProvider.notifier).save(Saep(
                    companyId: companyId!,
                    name: nameController.text,
                    populationSize: int.tryParse(populationSizeController.text),
                    reservoirSize: double.tryParse(reservoirController.text),
                    waterResource: WaterResource.values.byName(waterResource),
                    saepType: SaepType.values.byName(saepType)));
                Navigator.of(context).pop();
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
