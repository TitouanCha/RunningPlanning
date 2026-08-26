import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/use_cases/add/add_steps_use_case.dart';

part 'add_steps_event.dart';
part 'add_steps_state.dart';

class AddStepsBloc extends Bloc<AddStepsEvent, AddStepsState> {

  final AddStepsUseCase addSteps;

  AddStepsBloc({ required this.addSteps}) : super(AddStepsState()) {
    on<InitStepId>((event, emit) => emit(state.copyWith(stepId: event.prepaId)));
    on<AddStep>(_onAddStep);
  }

  Future<void> _onAddStep(AddStep event, Emitter<AddStepsState> emit) async {
    emit(state.copyWith(stepStatus: StepStatus.loading));
    try {
      final success = await addSteps(state.stepId, event.stepName, event.stepDescription, event.startDate, event.endDate);
      if(success){
        emit(state.copyWith(stepStatus: StepStatus.success));
      } else {
        emit(state.copyWith(stepStatus: StepStatus.failure, errorMessage: "Failed to add step"));
      }
    } catch (e) {
      emit(state.copyWith(stepStatus: StepStatus.failure, errorMessage: e.toString()));
    }
  }
}
