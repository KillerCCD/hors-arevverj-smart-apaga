import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'package:smart_apaga/LoginRegister/Bloc/AddressBloc/AddressEvent.dart';
import 'package:smart_apaga/LoginRegister/Bloc/AddressBloc/AddressState.dart';
import 'package:smart_apaga/LoginRegister/Bloc/RegisterBloc/UserRepository.dart';
import 'package:smart_apaga/LoginRegister/Bloc/Validators.dart';
// import 'package:smart_apaga/LoginRegister/model/Addresses.dart';
// import 'package:smart_apaga/Pickup/Model/Pickup.dart';
import 'package:smart_apaga/globals.dart';

enum AddressAction { Ongoing, Passed, Cancel }

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  UserRepository userRepositroy;
  AddressBloc({UserRepository userRepositroy})
      : userRepositroy = userRepositroy,
        super(AddressState.initial());

  Stream<AddressState> _mapLoginSubmittedToState(Map userMap) async* {
    yield AddressState.loading(userMap);
    try {
      final dynamic token = await FlutterSession().get('token');

      var url = Uri.parse(ApiEndpoints.addressAdd);
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(userMap),
        // body: userMap,
      );
      print(response.body);
      print("Statuse Code Address${response.statusCode}");

      var body = jsonDecode(response.body);
      var data = body['data'];
      if (body['status'] == 1) {
        if (data != null) {
          yield AddressState.success();
        }
      } else {
        yield AddressState.failure();
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Stream<AddressState> mapEventToState(AddressEvent event) async* {
    if (event is AddressStreetNameChanged) {
      yield* _mapStreetnameChangedtoState(event.streetName);
    } else if (event is AddressBgdChanged) {
      yield* _mapBdgChangedtoState(event.bgd);
    } else if (event is AddressAptChanged) {
      yield* _mapAptChangedtoState(event.apt);
    } else if (event is AddressfloorChanged) {
      yield* _mapFloorChangedtoState(event.floor);
    } else if (event is AddressEntryChanged) {
      yield* _mapEntryChangedtoState(event.entry);
    } else if (event is AddressComentChanged) {
      yield* _mapComentChangedtoState(event.coment);
    } else if (event is AddressLongitudeChanged) {
      yield* _mapLongitudeChangeTostate(event.longitude);
    } else if (event is AddressLatitudeChanged) {
      yield* _mapLantitudeChangeToState(event.latitude);
    } else if (event is AddressSubmitted) {
      // print(event.addresses.toMap());
      yield* _mapLoginSubmittedToState(event.addresses.toMap());
    }
    //throw UnimplementedError();
  }

  Stream<AddressState> _mapStreetnameChangedtoState(String street) async* {
    yield state.update(isStreetNameValid: Validators.isValidStreetName(street));
  }

  Stream<AddressState> _mapBdgChangedtoState(String bdg) async* {
    yield state.update(isBdgValid: Validators.isValidBdg(bdg));
  }

  Stream<AddressState> _mapAptChangedtoState(String apt) async* {
    yield state.update(isAptValid: Validators.isValidapt(apt));
  }

  Stream<AddressState> _mapFloorChangedtoState(String floor) async* {
    yield state.update(isFloorValid: Validators.isValidfloor(floor));
  }

  Stream<AddressState> _mapEntryChangedtoState(String entry) async* {
    yield state.update(isEntryValid: Validators.isValidEntry(entry));
  }

  Stream<AddressState> _mapComentChangedtoState(String comment) async* {
    yield state.update(isComentValid: Validators.isValidComent(comment));
  }

  Stream<AddressState> _mapLongitudeChangeTostate(String longitude) async* {
    yield state.update(
        isLongitudeValid: Validators.isValidLongitude(longitude));
  }

  Stream<AddressState> _mapLantitudeChangeToState(String latitude) async* {
    yield state.update(isLatitudeValid: Validators.isValidLatitude(latitude));
  }
}




// int counter;
  // final _stateStreamController = StreamController<List<Address>>();

  // List<Pickup> pickups;
  // StreamSink<List<Address>> get _addressSink => _stateStreamController.sink;
  // Stream<List<Address>> get addressStream => _stateStreamController.stream;

  // final _eventStreamController = StreamController<String>();
  // StreamSink<String> get eventSink => _eventStreamController.sink;
  // Stream<String> get _eventStream => _eventStreamController.stream;

  // AddressBloc() : super(null) {
  //   _eventStream.listen((event) async {
  //     try {
  //       String url;
  //       if (event == ApiEndpoints.addressAdd) {
  //         url = ApiEndpoints.pickupsOngoing;
  //       } else if (event == ApiEndpoints.pickupsPassed) {
  //         url = ApiEndpoints.pickupsPassed;
  //       }
  //       var pickups = await _fetchAddresses(url);
  //       if (pickups != null)
  //         _addressSink.add(pickups);
  //       else
  //         _addressSink.addError('Samthing went wrong');
  //     } on Exception catch (e) {
  //       _addressSink.addError('Samthing went wrong: $e');
  //     }
  //   });
  // }


  // void dispose() {
  //   _stateStreamController.close();
  //   _eventStreamController.close();
  // }// Future<List<Address>> _fetchAddresses(String url) async {
  //   dynamic token = await FlutterSession().get('token');
  //   List<Address> addresses = [];

  //   try {
  //     final response = await http.get(Uri.parse(url), headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $token',
  //     });

  //     var body = jsonDecode(response.body);

  //     if (body['status'] == 1) {
  //       dynamic data = body['data'];
  //       data.forEach((element) {
  //         Address address = Address.fromJson(element);
  //         addresses.add(address);
  //       });
  //       pickups = List<Pickup>.from(data.map((e) => Pickup.fromJson(e)));
  //       return addresses;
  //     }
  //   } catch (error) {
  //     return error; //throw Exception('Failed to load album');
  //   }
  //   return addresses;
  // }