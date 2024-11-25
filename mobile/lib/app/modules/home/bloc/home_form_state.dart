part of 'home_form_bloc.dart';

enum HomeFormStatus {
  data,
  invalid,
  valid,
}

final class HomeFormState extends Equatable {
  final HomeFormStatus state;
  final List<GlobalKey<FormState>> formStates;

  const HomeFormState({required this.state, required this.formStates});

  @override
  List<Object?> get props => [state, formStates];
  HomeFormState copyWith({required HomeFormStatus state, List<GlobalKey<FormState>>? formStates}) {
    return HomeFormState(state: state, formStates: formStates ?? this.formStates);
  }
}
