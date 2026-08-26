
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'package:running_planning/core/errors/failures.dart';
import 'package:running_planning/data/data_sources/prepa/prepa_data_source.dart';

import 'package:running_planning/domain/entities/prepa.dart';
import 'package:running_planning/domain/entities/step.dart';

import '../../domain/repositories/prepa_repository.dart';
import '../models/add_step_model.dart';

class PrepaRepositoryImpl extends PrepaRepository {
  final PrepaDataSource _dataSource;

  PrepaRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, Prepa>> getPrepaById(String prepaId) async {
    try {
      final Prepa prepa = await _dataSource.getPrepaById(prepaId);
      return Future.value(Right(prepa));
    } catch (e) {
      if (e is NetworkFailure) {
        return Left(FetchFailure(e.message));
      }
      return Left(FetchFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Prepa>>> getPrepas() async{
    try {
      final List<Prepa> prepas = await _dataSource.getPrepas();
      return Future.value(Right(prepas));
    } catch (e) {
      if (e is NetworkFailure) {
        return Left(FetchFailure(e.message));
      }
      return Left(FetchFailure(e.toString()));
    }

  }

  @override
  Future<Either<Failure, List<Prepa>>> getUserPrepas() async {
    try {
      final List<Prepa> prepas = await _dataSource.getUserPrepas();
      return Future.value(Right(prepas));
    } catch (e) {
      if (e is NetworkFailure) {
        return Left(FetchFailure(e.message));
      }
      return Left(FetchFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> joinPrepa(String prepaId) async {
    try {
      await _dataSource.joinPrepa(prepaId);
      return Future.value(Right(null));
    } catch (e) {
      if (e is NetworkFailure) {
        return Left(FetchFailure(e.message));
      }
      return Left(FetchFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> leavePrepa(String prepaId) async {
    try {
      await _dataSource.leavePrepa(prepaId);
      return Future.value(Right(null));
    } catch (e) {
      if (e is NetworkFailure) {
        return Left(FetchFailure(e.message));
      }
      return Left(FetchFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TrainingStep>>> addSteps(String prepaId ,List<AddStepModel> steps) async {
    try {
      final List<TrainingStep> newStep = await _dataSource.addSteps(prepaId, steps);
      return Future.value(Right(newStep));
    } catch (e) {
      if (e is NetworkFailure) {
        return Left(FetchFailure(e.message));
      }
      return Left(FetchFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Prepa>> savePrepa(String prepa) {
    // TODO: implement savePrepa
    throw UnimplementedError();
  }
}