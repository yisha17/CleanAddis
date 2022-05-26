part of 'user_waste_bloc.dart';

@immutable
abstract class UserWasteEvent extends Equatable {
  const UserWasteEvent();
}

class HomePageOpenedEvent extends UserWasteEvent{

  @override
  List<Object?> get props => [];

}

class  DetailPageEvent extends UserWasteEvent{
  final String for_waste;
  final String type;
  DetailPageEvent({required this.for_waste,required this.type});
  
  @override
  List<Object?> get props => [for_waste,type];
}
