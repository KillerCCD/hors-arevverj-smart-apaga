import 'dart:convert';
import 'dart:developer';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:provider/provider.dart';
import 'package:smart_apaga/Extention/MenuButton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smart_apaga/LoginRegister/model/Address.dart';
import 'package:smart_apaga/Pickup/View/SchedulScreen.dart';
import 'package:smart_apaga/Pickup/View/WastTypeScreen.dart';
import 'package:smart_apaga/Pickup/View/Widgets/provider.dart';
import 'package:smart_apaga/globals.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderBags extends StatefulWidget {
  final bool dontBag;
  OrderBags(this.dontBag);
  OrderBagsState createState() => OrderBagsState(this.dontBag);
}

class OrderBagsState extends State<OrderBags> {
  int count = 0;
  int priceValue = 1200;
  bool dontBag;
  OrderBagsState(this.dontBag);
  Future<List<Address>> futureAddres;
  List<Address> addresLs = [];
  int addressMenuid = 0;
  Address addressSeletion = Address();
  @override
  void initState() {
    super.initState();
    setState(() {
      futureAddres = fetchAddress();
    });
  }

  // ignore: missing_return
  Future<List<Address>> fetchAddress() async {
    try {
      String token = await FlutterSession().get('token');
      // List<Address> addressLt = [];
      final response = await http.get(
        Uri.parse(ApiEndpoints.address),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      // var body = jsonDecode(response.body);
      print('Contact_Address_StatuseCode = ${response.statusCode}');
      var body = jsonDecode(response.body);
      inspect(body);
      if (body['status'] == 1) {
        dynamic data = body['data'];

        data.forEach((element) {
          Address address = Address.fromJson(element);

          addresLs.add(address);
        });

        return addresLs;
      } else {
        throw Exception("Can't load address");
      }
    } catch (error) {
      print(error);
    }
  }

  Widget build(context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      endDrawer: MenuButton(),
      appBar: AppBar(
        backgroundColor: Colors.green.shade300,
        leading: IconButton(
          onPressed: () {
            context.read<PickupBagProvider>().deletWastType();
            Navigator.pop(context, true);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(padding: EdgeInsets.all(10.0)),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 0)),
                    Image(
                      height: MediaQuery.of(context).size.width * 0.14,
                      image: AssetImage('assets/images/logo.png'),
                    ),
                  ],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context).orderBags,
                    style: TextStyle(fontSize: 24.0),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Divider(
                color: Colors.black,
                endIndent: 10,
                indent: 10,
              ),
              SizedBox(
                height: 20.0,
              ),
              Image(
                  height: 150,
                  width: 150,
                  image: AssetImage('assets/images/bag.png')),
              SizedBox(
                height: 10,
              ),

              //Quality
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(
                  //   width: screenSize.width / 3.0,
                  // ),
                  Text(
                    "${AppLocalizations.of(context).quantityText} :",
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    width: screenSize.width * 0.01,
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.green),
                    child: Row(
                      children: [
                        InkWell(
                            onTap: () {
                              setState(() {
                                count = max(count - 1, 0);
                              });
                            },
                            child: Icon(
                              Icons.remove,
                              color: Colors.white,
                              size: 16,
                            )),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 12),
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.white),
                          child: Text(
                            '$count',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              setState(() {
                                count++;
                              });
                            },
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 16,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 17.0,
              ),

              Container(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    "${AppLocalizations.of(context).totalText} : 1200\֏",
                    style: TextStyle(fontSize: 20),
                  ),
                ]),
                // child:
              ),

              //alignment: Alignment.bottomCenter,
              SizedBox(
                height: 40.0,
              ),
              Divider(
                color: Colors.black,
                endIndent: 10,
                indent: 10,
              ),
              SizedBox(
                height: 40.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ElevatedButton(
                  //   style: ElevatedButton.styleFrom(
                  //     primary: Colors.green.shade700,
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(18.0),
                  //     ),
                  //   ),
                  //   onPressed: () {
                  //     final url = 'https://rarible.com/';
                  //     openBrowserURL(url: url, inApp: false).whenComplete(() =>
                  //         Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //                 builder: (context) => SchedulScreen())));
                  //     context.read<PickupBagProvider>().newBags(count);
                  //   },
                  //   child: Text(
                  //     'CONFIRM',
                  //     style: TextStyle(color: Colors.white),
                  //   ),
                  // ),
                  // SizedBox(
                  //   width: 30,
                  // ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(200, 0),
                      primary: Colors.green.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                    onPressed: () {
                      if (dontBag) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (constext) => WastTypeScreen()));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (constext) => SchedulScreen()));
                      }
                    },
                    child: Text(
                      'Next',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }

  Future openBrowserURL({@required String url, bool inApp = false}) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: inApp,
        forceWebView: inApp,
        enableJavaScript: true,
      );
    }
  }
}
