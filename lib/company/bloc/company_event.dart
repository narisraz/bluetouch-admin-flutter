part of 'company_bloc.dart';

abstract class CompanyEvent extends Equatable {
  const CompanyEvent();
}

class CompanyEventAdd extends CompanyEvent {
  final String name;

  const CompanyEventAdd({required this.name});

  @override
  List<Object?> get props => [];
}

class CompanyEventGetAll extends CompanyEvent {
  @override
  List<Object?> get props => [];
}
