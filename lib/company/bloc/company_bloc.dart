import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bluetouch_admin/company/models/company.dart';
import 'package:bluetouch_admin/company/repository/company_repository.dart';
import 'package:equatable/equatable.dart';

part 'company_event.dart';
part 'company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  final CompanyRepository companyRepository;

  CompanyBloc({required this.companyRepository})
      : super(const CompanyState(companies: [])) {
    on<CompanyEventAdd>(_onAddCompany);
    on<CompanyEventGetAll>(_onGetAllCompanies);
  }

  FutureOr<void> _onAddCompany(
      CompanyEventAdd event, Emitter<CompanyState> emit) async {
    try {
      await companyRepository.add(Company(name: event.name));
      emit(const CompanyState(status: CompanyStatus.added));
    } catch (e) {
      emit(const CompanyState(status: CompanyStatus.fail));
    }
  }

  FutureOr<void> _onGetAllCompanies(
      CompanyEventGetAll event, Emitter<CompanyState> emit) async {
    try {
      final List<Company> companies = await companyRepository.getAll();
      emit(CompanyState(companies: companies, status: CompanyStatus.success));
    } catch (e) {
      emit(const CompanyState(status: CompanyStatus.fail));
    }
  }
}
