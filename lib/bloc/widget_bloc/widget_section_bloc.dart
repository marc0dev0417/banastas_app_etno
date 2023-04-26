import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'widget_section_event.dart';
part 'widget_section_state.dart';

class WidgetSectionBloc extends HydratedBloc<WidgetSectionEvent, WidgetSectionState> {
  WidgetSectionBloc() : super(WidgetSectionState.initial()) {
    on<FilterWidgetSection>((event, emit) {
      switch (event.buttonIndex){
        case 1: emit(state.copyWith(sectionNameOne: event.sectionName));
        break;
        case 2: emit(state.copyWith(sectionNameTwo: event.sectionName));
        break;
        case 3: emit(state.copyWith(sectionNameThree: event.sectionName));
        break;
        case 4: emit(state.copyWith(sectionNameFour: event.sectionName));
        break;
      }
    });
  }

  @override
  WidgetSectionState? fromJson(Map<String, dynamic> json) {
    return WidgetSectionStateCopy(
        sectionNameOne: json['section_one'] as String,
        sectionNameTwo: json['section_two'] as String,
        sectionNameThree: json['section_three'] as String,
        sectionNameFour: json['section_four'] as String
    );
  }

  @override
  Map<String, dynamic>? toJson(WidgetSectionState state) {
    return {
      'section_one': state.sectionNameOne,
      'section_two': state.sectionNameTwo,
      'section_three': state.sectionNameThree,
      'section_four': state.sectionNameFour
    };
  }
}
