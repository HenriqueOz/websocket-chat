import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'home_form_event.dart';
part 'home_form_state.dart';

class HomeFormBloc extends Bloc<HomeFormEvent, HomeFormState> {
  HomeFormBloc()
      : super(
          const HomeFormState(
            state: HomeFormStatus.data,
            formStates: [],
          ),
        ) {
    on<HomeFormAddFormState>(_addFormState);
    on<HomeFormSubmit>(_submitForm);
    on<HomeFormAddUserController>(_addUserController);
    on<HomeFormAddIpController>(_addIpController);
    on<HomeFormAddPortController>(_addPortController);
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
      event.onError(state);
      emit(state.copyWith(state: HomeFormStatus.invalid));
    } else {
      event.onSuccess(state);

      emit(state.copyWith(state: HomeFormStatus.valid));
    }
  }

  Future<void> _addUserController(HomeFormAddUserController event, Emitter<HomeFormState> emit) async {
    emit(state.copyWith(state: HomeFormStatus.data, userTextController: event.controller));
  }

  FutureOr<void> _addPortController(HomeFormAddPortController event, Emitter<HomeFormState> emit) {
    emit(state.copyWith(state: HomeFormStatus.data, portTextController: event.controller));
  }

  FutureOr<void> _addIpController(HomeFormAddIpController event, Emitter<HomeFormState> emit) {
    emit(state.copyWith(state: HomeFormStatus.data, ipTextController: event.controller));
  }
}
