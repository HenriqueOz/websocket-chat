import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'home_form_event.dart';
part 'home_form_state.dart';

class HomeFormBloc extends Bloc<HomeFormEvent, HomeFormState> {
  HomeFormBloc()
      : super(const HomeFormState(
          state: HomeFormStatus.data,
          formStates: [],
        )) {
    on<HomeFormAddFormState>(_addFormState);
    on<HomeFormSubmit>(_submitForm);
  }
  Future<void> _addFormState(HomeFormAddFormState event, Emitter<HomeFormState> emit) async {
    final List<GlobalKey<FormState>> formStates = [...state.formStates];

    if (!formStates.contains(event.formState)) {
      formStates.add(event.formState);
    }
    emit(state.copyWith(state: HomeFormStatus.data, formStates: formStates));
  }

  Future<void> _submitForm(HomeFormSubmit event, Emitter<HomeFormState> emit) async {
    final List<bool> validations = state.formStates
        .map<bool>(
          (element) => element.currentState?.validate() ?? false,
        )
        .toList();

    if (validations.contains(false)) {
      event.onError();
      emit(state.copyWith(state: HomeFormStatus.invalid));
    } else {
      event.onSuccess();
      emit(state.copyWith(state: HomeFormStatus.valid));
    }
  }
}
