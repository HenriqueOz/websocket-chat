// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_form_bloc.dart';

sealed class HomeFormEvent {}

class HomeFormAddFormState extends HomeFormEvent {
  final GlobalKey<FormState> formState;
  HomeFormAddFormState({required this.formState});
}

class HomeFormSubmit extends HomeFormEvent {
  final void Function() onError;
  final void Function() onSuccess;

  HomeFormSubmit({
    required this.onError,
    required this.onSuccess,
  });
}
