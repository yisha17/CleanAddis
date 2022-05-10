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

  UserWasteBloc(this._wasteRepository) : super(WasteLoadingState());

  void detailPage({String? for_waste, String? type }){
    add(DetailPageEvent(for_waste: for_waste!,type: type!));
  }

  Stream<UserWasteState> mapEventToState(
    UserWasteEvent event,
  ) async* {
    if (event is HomePageOpenedEvent){
       try {
        yield WasteLoadingState();
        final _storage = const FlutterSecureStorage();
        String? user_id = await _storage.read(key: 'id');
        String? token = await _storage.read(key: 'token');
        final waste = await _wasteRepository.fetchUserWaste(user_id!, token!);
        print(waste);
        await Future.delayed(Duration(seconds: 3));
        yield WasteLoaded(waste!);
        print("waste loaded");
      } catch (e) {
        yield GetErrorState(error: e.toString());
      }
    }

    if (event is DetailPageEvent){
      try {
        yield WasteLoadingState();
        final _storage = const FlutterSecureStorage();
        String? user_id = await _storage.read(key: 'id');
        String? token = await _storage.read(key: 'token');
        final waste = await _wasteRepository.fetchUserWasteByType(user_id!, token!,event.for_waste,event.type);
        print(waste);
        await Future.delayed(Duration(seconds: 3));
        yield WasteLoaded(waste!);
        print("waste loa767ded");
      } catch (e) {
        yield GetErrorState(error: e.toString());
      }
    }
   
  }
}
