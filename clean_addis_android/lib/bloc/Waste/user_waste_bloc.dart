import 'package:bloc/bloc.dart';
import 'package:clean_addis_android/data/models/waste.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'user_waste_event.dart';
part 'user_waste_state.dart';

class UserWasteBloc extends Bloc<UserWasteEvent, UserWasteState> {
  
  UserWasteBloc() {
    on<UserWasteEvent>((event, emit) {
     
    });
  }
}
