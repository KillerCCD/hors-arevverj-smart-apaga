import 'package:equatable/equatable.dart';

import 'package:smart_apaga/Pickup/Model/Pickup.dart';

abstract class PickupStates extends Equatable {
  final PickupState pickupState;
  PickupStates({
    this.pickupState,
  });

  List<Object> get props => [pickupState];
}

class PickupState extends PickupStates {
  final String note;
  final Pickup pickup;
  PickupState({this.note, this.pickup});

  List<Object> get props => [note, pickup];
  PickupState update({
    String note,
    Pickup pickup,
  }) {
    return copyWith(
      note: note,
      pickup: pickup,
    );
  }

  PickupState copyWith({
    String note,
    Pickup pickup,
  }) {
    return PickupState(note: note, pickup: pickup);
  }
}

class PickupInitial extends PickupState {
  PickupInitial();
}

class PickupSuccess extends PickupState {
  PickupSuccess();
}

class PickupFailure extends PickupState {
  PickupFailure();
}

class PickupInProgress extends PickupState {
  PickupInProgress();
}
