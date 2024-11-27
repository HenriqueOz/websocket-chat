import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:websocket_flutter/app/core/hive/hive_boxes.dart';

part 'home_form_event.dart';
part 'home_form_state.dart';

class HomeFormBloc extends Bloc<HomeFormEvent, HomeFormState> {
  HomeFormBloc()
      : super(
          const HomeFormState(
            state: HomeFormStatus.data,
            formStates: [],
            textControllers: {},
          ),
        ) {
    on<HomeFormAddFormState>(_addFormState);
    on<HomeFormSubmit>(_submitForm);
    on<HomeFormAddController>(_addController);
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

      final Box<String> formBox = await Hive.openBox(HiveBoxes.formAutoFill);

      formBox.putAll({
        'user_controller': state.textControllers['user_controller']?.text ?? '',
        'ip_controller': state.textControllers['ip_controller']?.text ?? '',
        'port_controller': state.textControllers['port_controller']?.text ?? '',
      });

      emit(state.copyWith(state: HomeFormStatus.valid));
    }
  }

  Future<void> _addController(HomeFormAddController event, Emitter<HomeFormState> emit) async {
    print(state.textControllers);

    final Map<String, TextEditingController> textControllers = {
      //...state.textControllers,
      event.key: event.controller,
    };

    final String? storedValue = await _getStoredValue(key: event.key);

    if (storedValue != null) {
      textControllers[event.key]?.text = storedValue;
    }

    emit(state.copyWith(
      state: HomeFormStatus.data,
      textControllers: textControllers,
    ));
  }

  Future<String?> _getStoredValue({required String key}) async {
    final Box<String> formBox = await Hive.openBox(HiveBoxes.formAutoFill);

    return formBox.get(key);
  }
}
