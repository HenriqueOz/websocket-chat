// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_form_bloc.dart';

sealed class HomeFormEvent {}

class HomeFormAddFormState extends HomeFormEvent {
  final GlobalKey<FormState> formState;
  HomeFormAddFormState({required this.formState});
}

class HomeFormAddUserController extends HomeFormEvent {
  final TextEditingController controller;
  HomeFormAddUserController({required this.controller});
}

class HomeFormAddIpController extends HomeFormEvent {
  final TextEditingController controller;
  HomeFormAddIpController({required this.controller});
}

class HomeFormAddPortController extends HomeFormEvent {
  final TextEditingController controller;
  HomeFormAddPortController({required this.controller});
}

class HomeFormSubmit extends HomeFormEvent {
  final void Function(HomeFormState state) onError;
  final void Function(HomeFormState state) onSuccess;

  HomeFormSubmit({
    required this.onError,
    required this.onSuccess,
  });
}
