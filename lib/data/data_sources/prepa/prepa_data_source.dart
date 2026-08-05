
import 'package:running_planning/domain/entities/prepa.dart';

abstract class PrepaDataSource {
  Future<Prepa> createPrepa(Prepa prepa);
  Future<void> joinPrepa(String prepaId);
  Future<List<Prepa>> getPrepas();
  Future<List<Prepa>> getUserPrepas();
  Future<Prepa> getPrepaById(String prepaId);

}