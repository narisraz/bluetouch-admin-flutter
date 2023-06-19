import 'package:bluetouch_admin/company/models/saep.dart';

abstract class SaepRepository {
  Future<void> save(Saep saep);
}
