import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_apaga/LoginRegister/Bloc/AddressBloc/AddressBloc.dart';
import 'package:smart_apaga/LoginRegister/view/overal/AddressConfirmationForm.dart';

class AddressConfirmationScreen extends StatefulWidget {
  AddressConfirmationScreenState createState() =>
      AddressConfirmationScreenState();
}

class AddressConfirmationScreenState extends State<AddressConfirmationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AddressConfirmationForm(),
    );
  }
}
