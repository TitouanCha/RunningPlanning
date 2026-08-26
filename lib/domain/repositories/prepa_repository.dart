
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:running_planning/core/errors/failures.dart';
import 'package:running_planning/data/models/add_step_model.dart';
import 'package:running_planning/domain/entities/prepa.dart';
import 'package:running_planning/domain/entities/step.dart';

abstract class PrepaRepository {
  Future<Either<Failure, Prepa>> savePrepa(String prepa);
  Future<Either<Failure, List<Prepa>>> getPrepas();
  Future<Either<Failure, List<Prepa>>> getUserPrepas();
  Future<Either<Failure, Prepa>> getPrepaById(String prepaId);
  Future<Either<Failure, void>> joinPrepa(String prepaId);
  Future<Either<Failure, void>> leavePrepa(String prepaId);
  Future<Either<Failure, List<TrainingStep>>> addSteps(String prepaId, List<AddStepModel> step);
}
