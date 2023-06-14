part of 'company_bloc.dart';

enum CompanyStatus { initial, success, fail, added }

class CompanyState extends Equatable {
  final CompanyStatus status;
  final List<Company>? companies;

  const CompanyState({this.status = CompanyStatus.initial, this.companies});

  @override
  List<Object?> get props => [status, companies];
}
