
import 'package:running_planning/data/models/add_step_model.dart';
import 'package:running_planning/domain/repositories/prepa_repository.dart';

class AddStepsUseCase {
  final PrepaRepository repository;

  AddStepsUseCase(this.repository);
  Future<bool> call(String stepId, String stepName, String stepDescription, DateTime stepStartDate, DateTime stepEndDate) async {
    final AddStepModel step = AddStepModel(
      name: stepName,
      description: stepDescription,
      startDate: stepStartDate,
      endDate: stepEndDate,
    );
    final List<AddStepModel> steps = [step];
    final result = await repository.addSteps(stepId, steps);
    return result.fold(
      (failure) => false,
      (success) => true,
    );
  }
}