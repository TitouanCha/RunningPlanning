
import 'package:flutter/material.dart';

import '../../../domain/entities/step.dart';


abstract class StepDataSources {
  Future<TrainingStep> getStepById(String id);
  Future<List<TrainingStep>> getStepsByPrepaId(String prepaId);
  Future<TrainingStep> createPrepaStep(TrainingStep step, String prepaId);
}