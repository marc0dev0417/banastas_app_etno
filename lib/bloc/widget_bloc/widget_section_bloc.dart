import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../../models/widget_button/WidgetButton.dart';

part 'widget_section_event.dart';
part 'widget_section_state.dart';

class WidgetSectionBloc extends Bloc<WidgetSectionEvent, WidgetSectionState> with HydratedMixin{
  WidgetSectionBloc() : super(WidgetSectionState.initial()) {
    on<FilterWidgetSection>((event, emit) {
     List<WidgetButton> listToSave = state.listWidgetButton.where((element) => element.sectionName != event.sectionOldName).toList();
     listToSave = [...listToSave, WidgetButton(sectionName: 'Test')];
     emit(state.copyWith(list: listToSave));
    });
  }

  @override
  WidgetSectionState? fromJson(Map<String, dynamic> json) {
    return WidgetSectionState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(WidgetSectionState state) {
    return state.toMap();
  }
}
