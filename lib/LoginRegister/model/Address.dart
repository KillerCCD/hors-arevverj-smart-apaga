import 'package:smart_apaga/LoginRegister/model/Purchase.dart';

class Address {
  final String customerAddress;
  final String building;
  final String apartment;
  final String floor;
  final String entrance;
  final String comment;
  final String latitude;
  final List<Purchase> purchase;
  final String longitude;
  final String placeId;
  final int id;

  Address(
      {this.customerAddress,
      this.building,
      this.latitude,
      this.longitude,
      this.apartment,
      this.floor,
      this.entrance,
      this.comment,
      this.placeId,
      this.id,
      this.purchase});

  Map toMap() {
    return {
      'customer_address': customerAddress ?? '',
      'building': building,
      'apartment': apartment ?? '',
      'floor': floor ?? '',
      'entrance': entrance ?? '',
      'comment': comment ?? '',
      'latitude': latitude ?? '',
      'longitude': longitude ?? '',
      'placeId': placeId ?? '',
    };
  }

  Map toMap2() {
    return {
      'customer_address': customerAddress ?? '',
      'building': building,
      'apartment': apartment ?? '',
      'floor': floor ?? '',
      'entrance': entrance ?? '',
      'comment': comment ?? '',
      'latitude': latitude ?? '',
      'longitude': longitude ?? '',
      'placeId': placeId ?? '',
      'purchase': List<dynamic>.from(purchase.map((x) => x.toMap())) != null
          ? List<dynamic>.from(purchase.map((x) => x.toMap()))
          : [],
    };
  }

  factory Address.fromJson2(Map<String, dynamic> json) {
    return Address(
      customerAddress: json['customer_address'] as String,
      building: json['building'] as String,
      apartment: json['apartment'] as String,
      floor: json['floor'] as String,
      entrance: json['entrance'] as String,
      longitude: json['longitude'] as String,
      latitude: json['latitude'] as String,
      placeId: json['placeId'] as String,
      id: json['id'] as int,
      purchase: List<Purchase>.from(
                  json["purchase"].map((x) => Purchase.fromJson(x))) !=
              null
          ? List<Purchase>.from(
              json["purchase"].map((x) => Purchase.fromJson(x)))
          : [],
    );
  }
  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      customerAddress: json['customer_address'] as String,
      building: json['building'] as String,
      apartment: json['apartment'] as String,
      floor: json['floor'] as String,
      entrance: json['entrance'] as String,
      longitude: json['longitude'] as String,
      latitude: json['latitude'] as String,
      placeId: json['placeId'] as String,
      id: json['id'] as int,
      // purchase: List<Purchase>.from(
      //             json["purchase"].map((x) => Purchase.fromJson(x))) !=
      //         null
      //     ? List<Purchase>.from(
      //         json["purchase"].map((x) => Purchase.fromJson(x)))
      //     : [],
    );
  }
}
