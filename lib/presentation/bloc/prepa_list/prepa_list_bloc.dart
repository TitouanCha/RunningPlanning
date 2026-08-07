import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:running_planning/domain/use_cases/prepa/load_prepas_list_use_case.dart';
import '../../../domain/entities/prepa.dart';

part 'prepa_list_event.dart';
part 'prepa_list_state.dart';

class PrepaListBloc extends Bloc<PrepaListEvent, PrepaListState> {
  final LoadPrepasListUseCase loadPrepasList;

  PrepaListBloc({required this.loadPrepasList}) : super(const PrepaListState()) {
    on<LoadPrepaList>(_onLoadPrepaList);
    on<ChangePrepaFilter>(_onChangeFilter);
    on<ChangePrepaSort>(_onChangeSort);
  }

  Future<void> _onLoadPrepaList(LoadPrepaList event, Emitter<PrepaListState> emit) async {
    emit(state.copyWith(status: PrepaListStatus.loading));
    try {
      final result = await loadPrepasList();
      result.fold(
        (failure) => emit(state.copyWith(status: PrepaListStatus.error)),
        (prepas) {
          final sorted = _applySortAndFilter(prepas, state.filter, state.sort);
          emit(state.copyWith(
            status: PrepaListStatus.loaded,
            allPrepas: prepas,
            prepas: sorted,
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(status: PrepaListStatus.error, errorMessage: e.toString()));
    }
  }

  void _onChangeFilter(ChangePrepaFilter event, Emitter<PrepaListState> emit) {
    final filtered = _applySortAndFilter(state.allPrepas, event.filter, state.sort);
    emit(state.copyWith(filter: event.filter, prepas: filtered));
  }

  void _onChangeSort(ChangePrepaSort event, Emitter<PrepaListState> emit) {
    final sorted = _applySortAndFilter(state.allPrepas, state.filter, event.sort);
    emit(state.copyWith(sort: event.sort, prepas: sorted));
  }

  List<Prepa> _applySortAndFilter(List<Prepa> prepas, PrepaListFilter filter, PrepaListSort sort) {
    List<Prepa> result = List.from(prepas);

    // Filtre
    if (filter == PrepaListFilter.recent) {
      final limit = DateTime.now().subtract(const Duration(days: 30));
      result = result.where((p) => p.startDate.isAfter(limit)).toList();
    }

    // Tri
    result.sort((a, b) => switch (sort) {
      PrepaListSort.dateDesc => b.startDate.compareTo(a.startDate),
      PrepaListSort.dateAsc => a.startDate.compareTo(b.startDate),
      PrepaListSort.nameAsc => a.name.compareTo(b.name),
      PrepaListSort.nameDesc => b.name.compareTo(a.name),
      PrepaListSort.durationAsc => a.prepaDuration.compareTo(b.prepaDuration),
      PrepaListSort.durationDesc => b.prepaDuration.compareTo(a.prepaDuration),
    });

    return result;
  }
}
