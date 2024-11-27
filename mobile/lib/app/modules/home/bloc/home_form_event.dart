// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_form_bloc.dart';

sealed class HomeFormEvent {}

class HomeFormAddFormState extends HomeFormEvent {
  final GlobalKey<FormState> formState;
  HomeFormAddFormState({required this.formState});
}

class HomeFormAddController extends HomeFormEvent {
  final String key;
  final TextEditingController controller;

  HomeFormAddController({
    required this.key,
    required this.controller,
  });
}

class HomeFormSubmit extends HomeFormEvent {
  final void Function(HomeFormState state) onError;
  final void Function(HomeFormState state) onSuccess;

  HomeFormSubmit({
    required this.onError,
    required this.onSuccess,
  });
}
