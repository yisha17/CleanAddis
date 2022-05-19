part of 'publicplace_bloc.dart';

@immutable
abstract class PublicPlaceEvent extends Equatable {
  const PublicPlaceEvent();
}

class GetPublicPlaceEvent extends PublicPlaceEvent{
  final String type;

  GetPublicPlaceEvent({required this.type});
   
   @override
  List<Object?> get props => [this.type];

}
