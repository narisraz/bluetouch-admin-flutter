part of 'company_bloc.dart';

enum CompanyStatus { initial, success, fail }

abstract class CompanyState extends Equatable {
  const CompanyState();
}

class CompanyStateInitial extends CompanyState {
  @override
  List<Object?> get props => [];
}

class CompanyStateAdded extends CompanyState {
  final CompanyStatus addCompanyStatus;

  const CompanyStateAdded({this.addCompanyStatus = CompanyStatus.initial});

  @override
  List<Object> get props => [addCompanyStatus];
}
