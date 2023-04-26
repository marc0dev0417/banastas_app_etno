part of 'widget_section_bloc.dart';

class WidgetSectionState extends Equatable {
  final List<WidgetButton> listWidgetButton;

  WidgetSectionState({required this.listWidgetButton});

  factory WidgetSectionState.initial() {
    return WidgetSectionState(
        listWidgetButton: [
        WidgetButton(sectionName: 'Noticias'),
        WidgetButton(sectionName: 'Eventos'),
        WidgetButton(sectionName: 'Turismo'),
        WidgetButton(sectionName: 'Farmacia'),
    ]);
  }

  WidgetSectionState copyWith({ List<WidgetButton>? list }){
    return WidgetSectionState(listWidgetButton: list ?? this.listWidgetButton);
  }

  @override
  String toString() {
    return 'WidgetSectionState{listWidgetButton: $listWidgetButton}';
  }

  @override
  List<Object?> get props => [listWidgetButton];

  @override
  bool get stringify => true;

  Map<String, dynamic> toMap() {
    return {'list': listWidgetButton};
  }

  factory WidgetSectionState.fromMap(Map<String, dynamic> map) {
    return WidgetSectionState(listWidgetButton: map['list']);
  }

  String toJson() => json.encode(toMap());

  factory WidgetSectionState.fromJson(String source) => WidgetSectionState(listWidgetButton: json.decode(source));
}