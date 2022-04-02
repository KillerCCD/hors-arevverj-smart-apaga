import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:smart_apaga/LoginRegister/Bloc/RegisterBloc/RegisterEvent.dart';
import 'package:smart_apaga/LoginRegister/Bloc/RegisterBloc/RegisterState.dart';

import '../../../globals.dart';
import 'UserRepository.dart';
import '../Validators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository userRepository;
  String _token;
  RegisterBloc({UserRepository userRepository})
      : userRepository = userRepository,
        super(RegisterState.initial());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterFullNameChanged) {
      yield* _mapRegisterFullNameChangeToState(event.fullName);
    } else if (event is RegisterPhoneChanged) {
      yield* _mapRegisterPhoneChangeToState(event.phone);
    } else if (event is RegisterEmailChanged) {
      yield* _mapRegisterEmailChangeToState(event.email);
    } else if (event is RegisterPasswordChanged) {
      yield* _mapRegisterPasswordChangeToState(event.password);
    } else if (event is RegisterLegalNameChanged) {
      yield* _mapRegisterLegalNameChangeToState(event.legalName);
    } else if (event is RegisterTaxCodeChanged) {
      yield* _mapRegisterTaxCodeChangeToState(event.taxCode);
    } else if (event is RegisterCompanyEmailChanged) {
      yield* _mapRegisterCompanyEmailChangeToState(event.companyEmail);
    } else if (event is RegisterSubmitted) {
      //yield* _mapRegisterSubmittedToState(event.user.toMap());
      // dynamic token = await userRepository?.signIn(event.user.toMap());
      yield RegisterState.loading(event.user.toMap());
      final response = await http.post(
        Uri.parse(ApiEndpoints.register),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(event.user.toMap()),
      );

      var body = jsonDecode(response.body);

      var data = body['data'];
      var status = body['status'];
      // print(body);

      if (response.statusCode == 200 && status == 1) {
        _token = data['access_token'];
        yield RegisterState.success();
      } else {
        yield RegisterState.failure();
      }
    } else if (event is SetSmsCode) {
      yield* _mapSmsToState(event.smsCode);
    }
  }

  Stream<RegisterState> _mapRegisterFullNameChangeToState(String name) async* {
    yield state.update(isFullNameValid: Validators.isValidFullName(name));
  }

  Stream<RegisterState> _mapRegisterPhoneChangeToState(String phone) async* {
    yield state.update(isPhoneValid: Validators.isValidPhone(phone));
  }

  Stream<RegisterState> _mapRegisterEmailChangeToState(String email) async* {
    yield state.update(isEmailValid: Validators.isValidEmail(email));
  }

  Stream<RegisterState> _mapRegisterPasswordChangeToState(
      String password) async* {
    yield state.update(isPasswordValid: Validators.isValidPassword(password));
  }

  Stream<RegisterState> _mapRegisterLegalNameChangeToState(
      String legalName) async* {
    yield state.update(
        isLegalNameValid: Validators.isValidLegalName(legalName));
  }

  Stream<RegisterState> _mapRegisterTaxCodeChangeToState(
      String taxCode) async* {
    yield state.update(isTaxCodeValid: Validators.isValidTaxCode(taxCode));
  }

  Stream<RegisterState> _mapRegisterCompanyEmailChangeToState(
      String companyEmail) async* {
    yield state.update(
        isCompanyEmailValid: Validators.isValidCompanyEmail(companyEmail));
  }

  Stream<RegisterState> _mapSmsToState(String smsCode) async* {
    try {
      var response = await http.post(Uri.parse(ApiEndpoints.sendRegCode),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $_token',
          },
          body: jsonEncode(<String, String>{'code': smsCode}));
      var body = jsonDecode(response.body);
      var status = body['status'];
      if (response.statusCode == 200 && status == 1) {
        await FlutterSession().set('token', _token);
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('register', _token);
        yield RegisterState.smsSucess();
      } else {
        yield RegisterState.failure();
      }
    } catch (e) {
      print(e);
    }

    // try {
    //   final response = await http.post(
    //     Uri.parse(ApiEndpoints.register),
    //     headers: <String, String>{
    //       'Content-Type': 'application/json; charset=UTF-8',
    //     },
    //     body: json.encode(userMap),
    //   );

    //   var body = jsonDecode(response.body);

    //   var data = body['data'];
    //   print(body);

    //   if (response.statusCode == 200) {
    //     dynamic token = data['access_token'];

    //     yield* token;
    //     print(body);
    //     yield RegisterState.success();

    //     print(body);
    //   } else {}
    // } catch (error) {
    //   print(error);
    // }
  }
}
