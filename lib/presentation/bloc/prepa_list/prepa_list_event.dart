part of 'prepa_list_bloc.dart';

@immutable
sealed class PrepaListEvent {}

class LoadPrepaList extends PrepaListEvent {}

class ChangePrepaFilter extends PrepaListEvent {
  final PrepaListFilter filter;
  ChangePrepaFilter(this.filter);
}

class ChangePrepaSort extends PrepaListEvent {
  final PrepaListSort sort;
  ChangePrepaSort(this.sort);
}
