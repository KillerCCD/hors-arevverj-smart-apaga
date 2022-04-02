import 'package:smart_apaga/LoginRegister/Bloc/Validators.dart';

class RegisterState with Validators {
  final bool isFullNameValid;
  final bool isPhoneValid;
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isLegalNameValid;
  final bool isTaxCodeValid;
  final bool isCompanyEmailValid;

  final bool isCompany;
  final bool disclimer;

  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final bool isSmsActive;
  bool get _isUserValid =>
      isFullNameValid && isPhoneValid && isEmailValid && isPasswordValid;
  bool get _isCompanyValid =>
      isLegalNameValid && isTaxCodeValid && isCompanyEmailValid;

  bool get isFormValid => _isUserValid ? _isUserValid : _isCompanyValid;

  RegisterState({
    this.isFullNameValid,
    this.isPhoneValid,
    this.isEmailValid,
    this.isPasswordValid,
    this.isLegalNameValid,
    this.isTaxCodeValid,
    this.isCompanyEmailValid,
    this.isSubmitting,
    this.isSuccess,
    this.isFailure,
    this.isCompany,
    this.disclimer,
    this.isSmsActive,
  });

  factory RegisterState.initial() {
    return RegisterState(
        isFullNameValid: true,
        isPhoneValid: true,
        isEmailValid: true,
        isPasswordValid: true,
        isLegalNameValid: true,
        isTaxCodeValid: true,
        isCompanyEmailValid: true,
        isCompany: true,
        disclimer: true,
        isSubmitting: false,
        isSuccess: false,
        isFailure: false,
        isSmsActive: false);
  }

  factory RegisterState.loading(Map userMap) {
    return RegisterState(
      isFullNameValid: Validators.isValidFullName(userMap['fullName']) ?? true,
      isPhoneValid: Validators.isValidPhone(userMap['phoneNumber']),
      isEmailValid: Validators.isValidEmail(userMap['email']) ?? true,
      isPasswordValid: Validators.isValidPassword(userMap['password']) ?? true,
      isLegalNameValid: userMap['company'] != null
          ? Validators.isValidLegalName(userMap['company']['name'])
          : true,
      isTaxCodeValid: userMap['company'] != null
          ? Validators.isValidTaxCode(userMap['company']['taxCode'])
          : true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
      isSmsActive: false,
    );
  }

  factory RegisterState.failure() {
    return RegisterState(
        isFullNameValid: true,
        isPhoneValid: true,
        isEmailValid: true,
        isPasswordValid: true,
        isLegalNameValid: true,
        isTaxCodeValid: true,
        isCompanyEmailValid: true,
        isSubmitting: false,
        isSuccess: false,
        isFailure: true,
        isSmsActive: false);
  }
  factory RegisterState.smsSucess() {
    return RegisterState(
      isFullNameValid: true,
      isPhoneValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isLegalNameValid: true,
      isTaxCodeValid: true,
      isCompanyEmailValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
      isSmsActive: true,
    );
  }
  factory RegisterState.success() {
    return RegisterState(
      isFullNameValid: true,
      isPhoneValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isLegalNameValid: true,
      isTaxCodeValid: true,
      isCompanyEmailValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
      isSmsActive: false,
    );
  }

  RegisterState update(
      {bool isFullNameValid,
      bool isPhoneValid,
      bool isEmailValid,
      bool isPasswordValid,
      bool isLegalNameValid,
      bool isTaxCodeValid,
      bool isLegalAddressValid,
      bool isSdnValid,
      bool isCompanyEmailValid,
      bool isSmsActive}) {
    return copyWith(
        isFullNameValid: isFullNameValid,
        isPhoneValid: isPhoneValid,
        isEmailValid: isEmailValid,
        isPasswordValid: isPasswordValid,
        isLegalNameValid: isLegalNameValid,
        isTaxCodeValid: isTaxCodeValid,
        isLegalAddressValid: isLegalAddressValid,
        isSdnValid: isSdnValid,
        isCompanyEmailValid: isCompanyEmailValid,
        isSubmitting: false,
        isSuccess: false,
        isFailure: false,
        isSmsActive: false);
  }

  RegisterState copyWith({
    bool isFullNameValid,
    bool isPhoneValid,
    bool isEmailValid,
    bool isPasswordValid,
    bool isLegalNameValid,
    bool isTaxCodeValid,
    bool isLegalAddressValid,
    bool isSdnValid,
    bool isCompanyEmailValid,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
    bool isSmsActive,
  }) {
    return RegisterState(
      isFullNameValid: isFullNameValid ?? this.isFullNameValid,
      isPhoneValid: isPhoneValid ?? this.isPhoneValid,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isLegalNameValid: isLegalNameValid ?? this.isLegalNameValid,
      isTaxCodeValid: isTaxCodeValid ?? this.isTaxCodeValid,
      isCompanyEmailValid: isCompanyEmailValid ?? this.isCompanyEmailValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      isSmsActive: isSmsActive ?? this.isSmsActive,
    );
  }
}
