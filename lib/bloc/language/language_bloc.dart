import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends HydratedBloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageState.initial()) {
    on<SaveLanguageCode>((event, emit) {
      emit(state.copyWith(languageCode: event.languageCode));
    });
  }

  @override
  LanguageState? fromJson(Map<String, dynamic> json) {
    return LanguageCodeStateCopy(languageCode: json['language_code'] as String);
  }

  @override
  Map<String, dynamic>? toJson(LanguageState state) {
    return {
      'language_code': state.languageCode
    };
  }
}
