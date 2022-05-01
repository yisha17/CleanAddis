part of 'user_waste_bloc.dart';

@immutable
abstract class UserWasteState extends Equatable {}

class WasteLoadingState extends UserWasteState{
  @override
  List<Object?> get props =>[];
}


class WasteLoaded extends UserWasteState{
  final List<Waste> waste;
  WasteLoaded([this.waste = const []]);
  @override
  List<Object?> get props => [];
}

class GetErrorState extends UserWasteState{
  final String error;
  GetErrorState({required this.error});
  @override
  List<Object?> get props => [this.error];
}