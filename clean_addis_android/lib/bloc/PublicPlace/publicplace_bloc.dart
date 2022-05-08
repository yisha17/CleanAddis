import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'publicplace_event.dart';
part 'publicplace_state.dart';

class PublicplaceBloc extends Bloc<PublicplaceEvent, PublicplaceState> {
  PublicplaceBloc() : super(PublicplaceInitial()) {
    on<PublicplaceEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
