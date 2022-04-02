import 'package:equatable/equatable.dart';
import 'package:smart_apaga/LoginRegister/model/User.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterFullNameChanged extends RegisterEvent {
  final String fullName;

  RegisterFullNameChanged({this.fullName});

  @override
  List<Object> get props => [fullName];
}

class RegisterPhoneChanged extends RegisterEvent {
  final String phone;

  RegisterPhoneChanged({this.phone});

  @override
  List<Object> get props => [phone];
}

class RegisterEmailChanged extends RegisterEvent {
  final String email;

  RegisterEmailChanged({this.email});

  @override
  List<Object> get props => [email];
}

class RegisterPasswordChanged extends RegisterEvent {
  final String password;

  RegisterPasswordChanged({this.password});

  @override
  List<Object> get props => [password];
}

class RegisterLegalNameChanged extends RegisterEvent {
  final String legalName;

  RegisterLegalNameChanged({this.legalName});

  @override
  List<Object> get props => [legalName];
}

class RegisterTaxCodeChanged extends RegisterEvent {
  final String taxCode;

  RegisterTaxCodeChanged({this.taxCode});

  @override
  List<Object> get props => [taxCode];
}

class RegisterCompanyEmailChanged extends RegisterEvent {
  final String companyEmail;

  RegisterCompanyEmailChanged({this.companyEmail});

  @override
  List<Object> get props => [companyEmail];
}

class RegisterSubmitted extends RegisterEvent {
  final User user;


  RegisterSubmitted({
    this.user,
    
  });

  @override
  List<Object> get props => [user];
}

class SetSmsCode extends RegisterEvent {
  final String smsCode;
  SetSmsCode(this.smsCode);
  @override
  List<Object> get props => [smsCode];
}
