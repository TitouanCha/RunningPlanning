import 'package:dartz/dartz.dart';
import 'package:running_planning/core/errors/failures.dart';

import '../../entities/prepa.dart';
import '../../repositories/prepa_repository.dart';

class LoadPrepasListUseCase {
  final PrepaRepository repository;
  LoadPrepasListUseCase(this.repository);

  Future<Either<Failure, List<Prepa>>> call() async {
    final result = await repository.getPrepas();
    return result.map((prepas) {
      final sorted = List<Prepa>.from(prepas)
        ..sort((a, b) => b.startDate.compareTo(a.endDate));
      final filtered = sorted.where((prepa) => prepa.endDate.isAfter(DateTime.now())).toList();
      return filtered;
    });
  }
}