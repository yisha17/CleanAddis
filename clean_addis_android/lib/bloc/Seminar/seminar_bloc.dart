import 'package:bloc/bloc.dart';
import 'package:clean_addis_android/data/models/seminar.dart';
import 'package:clean_addis_android/data/repositories/seminar_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

part 'seminar_event.dart';
part 'seminar_state.dart';

class SeminarBloc extends Bloc<SeminarEvent, SeminarState> {
  SeminarRepo repository;
  SeminarBloc(this.repository) : super(SeminarInitial());


  Stream<SeminarState> mapEventToState(SeminarEvent event) async*{
    if (event is SeminarPageOpened){
     try{ yield SeminarInitial();
      final _storage = FlutterSecureStorage();
      final user_id = await _storage.read(key: 'id');
      String? token = await _storage.read(key: 'token');
      final seminars = await repository.getSeminar(token!);
      yield SeminarLoaded(seminars: seminars!);
      }catch(e){
        yield SeminarError(message: e.toString());
      }
    }
  }
}
