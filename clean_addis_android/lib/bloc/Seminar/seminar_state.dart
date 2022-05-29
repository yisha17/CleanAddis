part of 'seminar_bloc.dart';

@immutable
abstract class SeminarState extends Equatable {}

class SeminarInitial extends SeminarState {
   @override
  List<Object?> get props => [];
}

class SeminarLoaded extends SeminarState{
  final List<Seminar> seminars;
  SeminarLoaded({required this.seminars});
   @override
  List<Object?> get props => [seminars];
}

class SeminarError extends SeminarState{
  final String message;
  SeminarError({required this.message});
  @override
  List<Object?> get props => [message];
}
