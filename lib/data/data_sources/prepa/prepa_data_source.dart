
import 'package:flutter/material.dart';
import 'package:running_planning/data/models/add_step_model.dart';
import 'package:running_planning/domain/entities/prepa.dart';
import 'package:running_planning/domain/entities/step.dart';

abstract class PrepaDataSource {
  Future<Prepa> createPrepa(Prepa prepa);
  Future<void> joinPrepa(String prepaId);
  Future<void> leavePrepa(String prepaId);
  Future<List<Prepa>> getPrepas();
  Future<List<Prepa>> getUserPrepas();
  Future<Prepa> getPrepaById(String prepaId);
  Future<List<TrainingStep>> addSteps(String prepaId, List<AddStepModel> step);
}