import 'package:bluetouch_admin/company/infrastructure/saep_firestore_repository.dart';
import 'package:bluetouch_admin/company/repository/saep_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'saep_repository.g.dart';

@riverpod
SaepRepository saepRepository(SaepRepositoryRef ref) =>
    SaepFirestoreRepository(FirebaseFirestore.instance);
