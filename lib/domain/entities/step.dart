import 'package:running_planning/domain/entities/prepa.dart';

class TrainingStep {
  final String id;
  final String name;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final String prepaId;
  final String prepaName;
  final DateTime prepaStartDate;
  final bool isDone;

  TrainingStep({
    required this.id,
    required this.name,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.prepaId,
    required this.prepaName,
    required this.prepaStartDate,
    this.isDone = false,
  });

  factory TrainingStep.fromApi(Map<String, dynamic> json, [Prepa? prepa]){
    return TrainingStep(
        id: json['_id'] as String? ?? 'Aucune données cahrgé',
        name: json['name'] as String? ?? 'Aucune données cahrgé',
        description: json['description'] as String? ?? 'Aucune données cahrgé',
        startDate: DateTime.parse(json['startDate'] as String? ?? '2004-12-16'),
        endDate: DateTime.parse(json['endDate'] as String? ?? '2004-12-16'),
        prepaId: prepa?.id ?? 'Aucune données cahrgé',
        prepaName: prepa?.name ?? 'Aucune données cahrgé',
        prepaStartDate: prepa?.startDate ?? DateTime.parse('2004-12-16')
    );
  }

  TrainingStep checkStep({bool? isDone}) {
    return TrainingStep(
      id: id,
      name: name,
      description: description,
      startDate: startDate,
      endDate: endDate,
      prepaId: prepaId,
      prepaName: prepaName,
      prepaStartDate: prepaStartDate,
      isDone: isDone ?? this.isDone,
    );
  }
}
