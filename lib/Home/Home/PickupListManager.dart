import 'dart:developer';

import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_apaga/Pickup/PickupBloc/pickupState.dart';
import 'package:smart_apaga/globals.dart';
import 'package:smart_apaga/Home/Home/NoPickupItem.dart';
import 'package:smart_apaga/Pickup/Model/Pickup.dart';
import 'package:smart_apaga/Pickup/PickupBloc/PickupBlocWithEnum.dart';
import 'package:smart_apaga/Home/pickupList_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'OrderBagsItem.dart';
import 'edit_Screen.dart';

class PickupListManager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PickupListManagerState();
  }
}

class PickupListManagerState extends State<PickupListManager> {
  int groupedValue = 0;
  List<Pickup> _pickups = [];
  int nums;
  var val;
  PickupState pickupState = PickupState();
  PickupBlocs pickupBlocs = PickupBlocs();
  int purchasedBagCount = 5;
  bool isPassed = false;

  final _pickupBlocs = PickupBlocs();
  int _itemCount() {
    int count = _pickups.length == 0 ? _pickups.length + 1 : _pickups.length;
    print("itemCount----: $count");
    return purchasedBagCount != 0 ? count + 1 : count;
  }

  void _changeSegmentedControl(int value) {
    if (value == 0) {
      pickupBlocs.eventSink.add(ApiEndpoints.pickupsOngoing);
      isPassed = false;
    } else if (value == 1) {
      isPassed = true;
      pickupBlocs.eventSink.add(ApiEndpoints.pickupsPassed);
    }
  }

  @override
  void initState() {
    if (pickupBlocs.stateStreamController.isPaused) {
      setState(() {
        pickupBlocs.eventSink.add(ApiEndpoints.pickupsOngoing);
      });
    }

    //pickupBloc.eventSink.add(ApiEndpoints.pickupsPassed);
    super.initState();
  }

  @override
  void dispose() {
    pickupBlocs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    final Map<int, Widget> segmentedItemList = {
      0: Text(AppLocalizations.of(context).ongoingText,
          style: TextStyle(color: Colors.black)),
      1: Text(AppLocalizations.of(context).passedText,
          style: TextStyle(color: Colors.black))
    };
    return StreamBuilder<List<Pickup>>(
        stream: pickupBlocs.pickupStream,
        builder: (context, AsyncSnapshot<List<Pickup>> snapshot) {
          //  Widget dadas;

          if (snapshot.hasData || snapshot.data != null) {
            _pickups = snapshot.data;

            // var bags = _pickups
            //     .map((e) => e.address.purchase.map((e) => e.quantity))
            //     .toString();
            // var val = bags.replaceAll("(", '').replaceAll(")", '');
            // for (var bags in snapshot.data) {
            //   if (bags.address.purchase.length > 0) {
            //     val = bags.address.purchase.last.quantity;
            //   }
            // }
            // //  nums = int.parse(val);
            // inspect(val);
            isPassed = groupedValue == 0 ? false : true;
          } else if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Column(
            children: [
              Container(
                width: 300,
                child: CupertinoSegmentedControl<int>(
                    borderColor: Colors.grey,
                    selectedColor: Colors.grey,
                    unselectedColor: Colors.white,
                    children: segmentedItemList,
                    groupValue: groupedValue,
                    onValueChanged: (value) {
                      setState(() {
                        groupedValue = value;
                        _changeSegmentedControl(value);
                        print(value);
                      });
                    }),
              ),
              SizedBox(height: 20.0),
              snapshot.data.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                          key: Key(_pickups.length.toString()),
                          padding: EdgeInsets.all(20.0),
                          itemExtent: screenSize.width,
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            // if (val != 0 && index == 0) {
                            //   return OrderBagsItem(val ?? 0);
                            // }

                            if (_pickups.length != 0) {
                              //  int i = val != 0 ? index - 1 : index;

                              return Column(
                                children: [
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey[300])),
                                    child: Column(
                                      children: [
                                        PickupList(
                                          pickups: _pickups[index],
                                          isPassed: isPassed,
                                        ),
                                        SizedBox(height: 10.0),
                                        isPassed
                                            ? SizedBox(
                                                height: 0,
                                              )
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  SizedBox(
                                                    width: 20.0,
                                                  ),
                                                  Expanded(
                                                    child: ConstrainedBox(
                                                      constraints: BoxConstraints(
                                                          minWidth:
                                                              screenSize.width *
                                                                  0.3),
                                                      child: TextButton(
                                                        style: TextButton
                                                            .styleFrom(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          18.0),
                                                              side: BorderSide(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade300)),
                                                          primary:
                                                              Colors.grey[600],
                                                          textStyle: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                        ),
                                                        onPressed: () {
                                                          showBar(
                                                              context,
                                                              _pickups,
                                                              _pickups[index]);
                                                        },
                                                        child: Text(
                                                          AppLocalizations.of(
                                                                  context)
                                                              .cancelButton,
                                                          style: TextStyle(
                                                            fontSize: 14.0,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 20.0),
                                                  Expanded(
                                                    child: ConstrainedBox(
                                                      constraints: BoxConstraints(
                                                          minWidth:
                                                              screenSize.width *
                                                                  0.3),
                                                      child: TextButton(
                                                        style: TextButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              Colors.green
                                                                  .shade300,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          18.0),
                                                              side: BorderSide(
                                                                  color: Colors
                                                                      .green
                                                                      .shade300)),
                                                          primary: Colors.white,
                                                          textStyle: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                        ),
                                                        onPressed: () async {
                                                          // showBarEdit(context);
                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          EditScreen(
                                                                            pickups:
                                                                                _pickups[index],
                                                                          )));
                                                        },
                                                        child: Text(
                                                          AppLocalizations.of(
                                                                  context)
                                                              .editButtonText,
                                                          style: TextStyle(
                                                            fontSize: 14.0,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 20.0),
                                                ],
                                              ),
                                        SizedBox(height: isPassed ? 5 : 20),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }

                            return NoPickupItem();
                          }))
                  : NoPickupItem(),
            ],
          );

          //return dadas;
        });
  }

  Future<dynamic> showBar(
      BuildContext context, List<Pickup> pickups, Pickup pickup) {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: Text(AppLocalizations.of(context).cancelText2),
        content: Text(AppLocalizations.of(context).confirmCacel),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(AppLocalizations.of(context).noText)),
          TextButton(
              onPressed: () async {
                setState(() {
                  pickups.remove(pickup);
                  _pickupBlocs.eventSink
                      .add(ApiEndpoints.pickupCancel(pickup.id));
                });

                Navigator.of(context).pop(true);
                final snackBar = SnackBar(
                  backgroundColor: Colors.green.shade300,
                  content: Row(
                    children: [
                      Expanded(
                          child: Text(
                              AppLocalizations.of(context).pickupCancelText)),
                      SizedBox(
                        width: 19.0,
                        height: 19.0,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                        ),
                      ),
                    ],
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: Text(AppLocalizations.of(context).okText)),
        ],
      ),
    );
  }
}
