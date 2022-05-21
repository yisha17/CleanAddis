part of 'publicplace_bloc.dart';

class PublicPlaceState extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class PublicPlaceLoadingState extends PublicPlaceState{
  @override
  List<Object?> get props => [];
}

class PublicPlaceLoadedState extends PublicPlaceState{
  final List<PublicPlace> public;
  PublicPlaceLoadedState({required this.public});
  @override
  List<Object?> get props => [this.public];
}

class ErrorState extends PublicPlaceState{
  final String message;
  ErrorState({required this.message});
}
