part of 'widget_section_bloc.dart';

abstract class WidgetSectionEvent extends Equatable{

}
class FilterWidgetSection extends WidgetSectionEvent {

  final String sectionOldName;
  final String sectionName;

  FilterWidgetSection({required this.sectionOldName, required this.sectionName});

  @override
  List<Object?> get props => [sectionOldName, sectionName];
}