import 'package:bloc/bloc.dart';

part 'home_form_event.dart';
part 'home_form_state.dart';

class HomeFormBloc extends Bloc<HomeFormEvent, HomeFormState> {
  HomeFormBloc() : super(HomeFormInit()) {
    on<HomeFormEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
