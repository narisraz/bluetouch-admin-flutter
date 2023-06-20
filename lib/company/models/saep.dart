import 'package:bluetouch_admin/company/models/saep_type.dart';
import 'package:bluetouch_admin/company/models/water_resource.dart';

class Saep {
  final String? id;
  final String name;
  final int? populationSize;
  final double? reservoirSize;
  final WaterResource waterResource;
  final SaepType saepType;
  final String companyId;

  Saep(
      {this.id,
      this.populationSize,
      this.reservoirSize,
      required this.companyId,
      required this.name,
      required this.waterResource,
      required this.saepType});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'populationSize': populationSize,
      'reservoirSize': reservoirSize,
      'waterResource': waterResource.name,
      'saepType': saepType.name,
      'companyId': companyId
    };
  }

  static fromJson(Map<String, dynamic> data) {
    return Saep(
        id: data["id"],
        reservoirSize: double.tryParse('${data['reservoirSize']}'),
        populationSize: int.tryParse('${data['populationSize']}'),
        companyId: data['companyId'],
        name: data["name"],
        waterResource: WaterResource.values.byName(data['waterResource']),
        saepType: SaepType.values.byName(data['saepType']));
  }
}
