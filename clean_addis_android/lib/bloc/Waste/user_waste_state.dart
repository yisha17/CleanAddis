part of 'user_waste_bloc.dart';

@immutable
abstract class UserWasteState extends Equatable {}

class WasteLoading extends UserWasteState{
  @override
  List<Object?> get props => throw UnimplementedError();
}


class WasteLoaded extends UserWasteState{
  final List<Waste> waste;
  WasteLoaded([this.waste = const []]);
  @override
  List<Object?> get props => [this.waste];
}

class GetErrorState extends UserWasteState{
  final String error;
  GetErrorState({required this.error});
  @override
  List<Object?> get props => [this.error];
}