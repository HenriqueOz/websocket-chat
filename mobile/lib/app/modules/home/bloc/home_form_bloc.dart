import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:websocket_flutter/app/core/hive/hive_boxes.dart';

part 'home_form_event.dart';
part 'home_form_state.dart';

class HomeFormBloc extends Bloc<HomeFormEvent, HomeFormState> {
  HomeFormBloc()
      : super(
          HomeFormData(
            formStatus: FormStatus.empty,
            formStates: [],
            textControllers: {},
          ),
        ) {
    on<HomeFormAddFormState>(_addFormState);
    on<HomeFormSubmit>(_submitForm);
    on<HomeFormAddController>(_addController);
  }

  Future<void> _addFormState(HomeFormAddFormState event, Emitter<HomeFormState> emit) async {
    final HomeFormState current = state;

    if (current is HomeFormData) {
      final List<GlobalKey<FormState>> formStates = [...current.formStates];

      if (!formStates.contains(event.formState)) {
        formStates.add(event.formState);
      }

      emit(HomeFormData(
        formStatus: FormStatus.empty,
        formStates: formStates,
        textControllers: current.textControllers,
      ));
    }
  }

  Future<void> _submitForm(HomeFormSubmit event, Emitter<HomeFormState> emit) async {
    final HomeFormState current = state;

    if (current is HomeFormData) {
      final List<bool> validations = current.formStates
          .map<bool>(
            (element) => element.currentState?.validate() ?? false,
          )
          .toList();

      if (validations.contains(false)) {
        event.onError(current);
        emit(HomeFormData(
          formStatus: FormStatus.invalid,
          formStates: current.formStates,
          textControllers: current.textControllers,
        ));
      } else {
        event.onSuccess(current);

        final Box<String> formBox = await Hive.openBox(HiveBoxes.formAutoFill);

        formBox.putAll({
          'user_controller': current.textControllers['user_controller']?.text ?? '',
          'ip_controller': current.textControllers['ip_controller']?.text ?? '',
          'port_controller': current.textControllers['port_controller']?.text ?? '',
        });

        emit(HomeFormData(
          formStatus: FormStatus.valid,
          formStates: current.formStates,
          textControllers: current.textControllers,
        ));
      }
    }
  }

  Future<void> _addController(HomeFormAddController event, Emitter<HomeFormState> emit) async {
    final HomeFormState current = state;

    if (current is HomeFormData) {
      print(current.textControllers);

      final Map<String, TextEditingController> textControllers = {
        //...state.textControllers,
        event.key: event.controller,
      };

      final String? storedValue = await _getStoredValue(key: event.key);

      if (storedValue != null) {
        textControllers[event.key]?.text = storedValue;
      }

      emit(HomeFormData(
        formStatus: FormStatus.empty,
        formStates: current.formStates,
        textControllers: textControllers,
      ));
    }
  }

  Future<String?> _getStoredValue({required String key}) async {
    final Box<String> formBox = await Hive.openBox(HiveBoxes.formAutoFill);

    return formBox.get(key);
  }
}
