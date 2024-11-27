part of 'home_form_bloc.dart';

enum FormStatus {
  valid,
  invalid,
  empty,
}

sealed class HomeFormState {}

final class HomeFormData extends HomeFormState {
  final List<GlobalKey<FormState>> formStates;
  final Map<String, TextEditingController> textControllers;
  final FormStatus formStatus;
  HomeFormData({required this.formStatus, required this.formStates, required this.textControllers});
}
