part of 'prepa_list_bloc.dart';

enum PrepaListStatus { initial, loading, loaded, error }

enum PrepaListFilter {
  all,
  recent;

  String get label => switch (this) {
    PrepaListFilter.all => 'Tous',
    PrepaListFilter.recent => 'Récents (30j)',
  };
}

enum PrepaListSort {
  dateDesc,
  dateAsc,
  nameAsc,
  nameDesc,
  durationAsc,
  durationDesc;

  String get label => switch (this) {
    PrepaListSort.dateDesc => 'Date (récente)',
    PrepaListSort.dateAsc => 'Date (ancienne)',
    PrepaListSort.nameAsc => 'Nom (A → Z)',
    PrepaListSort.nameDesc => 'Nom (Z → A)',
    PrepaListSort.durationAsc => 'Durée (courte)',
    PrepaListSort.durationDesc => 'Durée (longue)',
  };
}

class PrepaListState {
  final PrepaListStatus status;
  final List<Prepa> prepas;
  final List<Prepa> allPrepas;
  final PrepaListFilter filter;
  final PrepaListSort sort;
  final String? errorMessage;

  const PrepaListState({
    this.status = PrepaListStatus.initial,
    this.prepas = const [],
    this.allPrepas = const [],
    this.filter = PrepaListFilter.all,
    this.sort = PrepaListSort.dateDesc,
    this.errorMessage,
  });

  PrepaListState copyWith({
    PrepaListStatus? status,
    List<Prepa>? prepas,
    List<Prepa>? allPrepas,
    PrepaListFilter? filter,
    PrepaListSort? sort,
    String? errorMessage,
  }) {
    return PrepaListState(
      status: status ?? this.status,
      prepas: prepas ?? this.prepas,
      allPrepas: allPrepas ?? this.allPrepas,
      filter: filter ?? this.filter,
      sort: sort ?? this.sort,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
