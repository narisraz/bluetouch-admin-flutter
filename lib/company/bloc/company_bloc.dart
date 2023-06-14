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
      : super(CompanyStateInitial()) {
    on<CompanyEventAdd>(_onAddCompany);
  }

  FutureOr<void> _onAddCompany(
      CompanyEventAdd event, Emitter<CompanyState> emit) async {
    try {
      await companyRepository.add(Company(name: event.name));
      emit(const CompanyStateAdded(addCompanyStatus: CompanyStatus.initial));
    } catch (e) {
      emit(const CompanyStateAdded(addCompanyStatus: CompanyStatus.fail));
    }
  }
}
