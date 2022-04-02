import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_apaga/Pickup/Model/Bag.dart';
import 'package:smart_apaga/Pickup/Model/Wast.dart';

class PickupBagProvider extends ChangeNotifier {
  final sharedPreferencces = SharedPreferences.getInstance();
  var pickupBags = <PickupBag>[];
  static final bagCodesSave = <String>[];
  var codeBag = <dynamic>[];
  int plastic = 0;
  int paper = 0;
  int glass = 0;
  int get plastics => plastic;
  int get papers => paper;
  int get glasess => glass;
  int newBagCounts = 0;
  static List<String> get saveBags => bagCodesSave;
  int get bagsNew => newBagCounts;
  List<dynamic> get bagCodes => codeBag ?? [];
  List<PickupBag> get pickups => pickupBags;

  void addBags(PickupBag bags) {
    pickupBags.add(bags);
    plastic = pickupBags
        .where((e) => e.wasteType.contains('plastic'))
        .toList()
        .length;
    paper =
        pickupBags.where((e) => e.wasteType.contains('paper')).toList().length;
    glass =
        pickupBags.where((e) => e.wasteType.contains('glass')).toList().length;
    saveBackCodeForCheck();
    inspect(pickupBags);
    notifyListeners();
  }

  void initPickupBas() {
    paper = 0;
    glass = 0;
    plastic = 0;
    newBagCounts = 0;
    pickupBags.clear();
    notifyListeners();
  }

  void deletWastType() {
    if (pickupBags.isNotEmpty) {
      pickupBags.removeLast();
    }

    inspect(pickupBags);
    notifyListeners();
  }

  // void updateBag(String type) {
  //   for (var i = 0; i < pickupBags.length; i++) {
  //     for (var j = 0; j < codeBag.length - 1; i++) {
  //       var ii = pickupBags[i].wasteType;
  //       print(ii);
  //       //var pp = ii.indexOf(codeBag[i]);
  //       // pickupBags[pp].wasteType = type;
  //     }
  //   }
  //   inspect(pickupBags);
  //   notifyListeners();
  // }

  void saveBackCodeForCheck() {
    var codesBags = pickupBags.last.bagCode;
    if (codeBag.isNotEmpty) {
      codeBag.add(codesBags);
    } else if (codeBag == null) {
      return null;
    }
    notifyListeners();
  }

  void codeBagss(String result) async {
    codeBag.add(result);
    bagCodesSave.add(result);
    inspect(bagCodesSave);
    notifyListeners();
  }

  void newBags(int bagCount) {
    newBagCounts = bagCount;
    notifyListeners();
  }
}
