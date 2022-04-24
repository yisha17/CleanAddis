import 'package:bloc/bloc.dart';
import 'package:clean_addis_android/data/models/waste.dart';
import 'package:clean_addis_android/data/repositories/waste_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

part 'user_waste_event.dart';
part 'user_waste_state.dart';



class UserWasteBloc extends Bloc<UserWasteEvent, UserWasteState> {
  WasteRepository _wasteRepository;
  
  
  UserWasteBloc(this._wasteRepository) : super(WasteLoading()) {
    on<HomePageOpenedEvent>((event, emit) async {
      emit(WasteLoading()) ;

      try{
        final _storage = const FlutterSecureStorage();
        String? user_id = await _storage.read(key: 'id');
        final waste = await _wasteRepository.fetchUserWaste(user_id!);
        print(waste);
        emit(WasteLoaded(waste!));
      }catch(e){
        GetErrorState(error: e.toString());
      }
    });
  }
}
