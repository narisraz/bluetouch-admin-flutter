import 'package:bluetouch_admin/company/infrastructure/user_firestore_repository.dart';
import 'package:bluetouch_admin/company/repository/client_user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'client_user_repository.g.dart';

@riverpod
ClientUserRepository clientUserRepository(ClientUserRepositoryRef ref) =>
    ClientUserFirestoreRepository(
        FirebaseFirestore.instance, FirebaseAuth.instance);
