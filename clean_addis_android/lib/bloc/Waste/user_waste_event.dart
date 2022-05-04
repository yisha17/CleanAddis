part of 'user_waste_bloc.dart';

@immutable
abstract class UserWasteEvent extends Equatable {
  const UserWasteEvent();
}

class HomePageOpenedEvent extends UserWasteEvent{

  @override
  List<Object?> get props => [];

}

class  DetailPageEvent extends UserWasteState{
  final List<Waste> waste;
  DetailPageEvent({required this.waste});
  
  @override
  List<Object?> get props => [];
}
