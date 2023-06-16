import 'package:bluetouch_admin/company/infrastructure/company_firestore_repository.dart';
import 'package:bluetouch_admin/company/repository/company_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'company_repository.g.dart';

@riverpod
CompanyRepository companyRepository(CompanyRepositoryRef ref) =>
    CompanyFirestoreRepository(FirebaseFirestore.instance);
