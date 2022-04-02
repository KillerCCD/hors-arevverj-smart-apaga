import 'package:flutter/material.dart';
import 'package:smart_apaga/Extention/MenuButton.dart';
import 'package:smart_apaga/MenuButton_screens/Contactifo_screen/contactInfo_form.dart';

class ContactScreen extends StatefulWidget {
  ContactScreenState createState() => ContactScreenState();
}

class ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        endDrawer: MenuButton(),
        appBar: AppBar(
          backgroundColor: Colors.green.shade300,
          iconTheme: IconThemeData(color: Colors.green.shade700),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: ContactInfoForm(),
      ),
    );
  }
}
