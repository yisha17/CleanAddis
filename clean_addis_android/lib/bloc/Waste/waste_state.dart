part of 'waste_bloc.dart';


class WasteState extends Equatable{
  final Waste? waste;
  WasteState({this.waste});

   @override
  List<Object?> get props => throw UnimplementedError();
}

class AddWasteWaitingState extends WasteState {
  @override
  List<Object?> get props => [];
}

class WasteCreatedState extends WasteState{
  final Waste waste;
  WasteCreatedState({required this.waste});
  @override
  List<Object?> get props => [this.waste];
}


class WasteCreateFailedState extends WasteState{
  final String message;
  WasteCreateFailedState(this.message);
   @override
  List<Object?> get props => [this.message];
}