part of 'company_bloc.dart';

abstract class CompanyState extends Equatable {
  const CompanyState();
}

class CompanyInitial extends CompanyState {
  @override
  List<Object> get props => [];
}
