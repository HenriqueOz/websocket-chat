// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_form_bloc.dart';

enum HomeFormStatus {
  data,
  invalid,
  valid,
}

class HomeFormState extends Equatable {
  final HomeFormStatus state;
  final List<GlobalKey<FormState>> formStates;
  final TextEditingController? userTextController;
  final TextEditingController? ipTextController;
  final TextEditingController? portTextController;

  const HomeFormState({
    required this.state,
    required this.formStates,
    this.ipTextController,
    this.portTextController,
    this.userTextController,
  });

  @override
  List<Object?> get props => [state, formStates, userTextController, ipTextController, portTextController];

  HomeFormState copyWith({
    HomeFormStatus? state,
    List<GlobalKey<FormState>>? formStates,
    TextEditingController? userTextController,
    TextEditingController? ipTextController,
    TextEditingController? portTextController,
  }) {
    return HomeFormState(
      state: state ?? this.state,
      formStates: formStates ?? this.formStates,
      userTextController: userTextController ?? this.userTextController,
      ipTextController: ipTextController ?? this.ipTextController,
      portTextController: portTextController ?? this.portTextController,
    );
  }
}
