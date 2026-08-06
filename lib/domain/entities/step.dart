class TrainingStep {
  final String id;
  final String name;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final String? prepaId;
  final String? prepaName;
  final String? prepaStartDate;

  TrainingStep({
    required this.id,
    required this.name,
    required this.description,
    required this.startDate,
    required this.endDate,
    this.prepaId,
    this.prepaName,
    this.prepaStartDate,
  });

  factory TrainingStep.fromApi(Map<String, dynamic> json){
    return TrainingStep(
        id: json['_id'] as String? ?? 'Aucune données cahrgé',
        name: json['name'] as String? ?? 'Aucune données cahrgé',
        description: json['description'] as String? ?? 'Aucune données cahrgé',
        startDate: DateTime.parse(json['startDate'] as String? ?? '2004-12-16'),
        endDate: DateTime.parse(json['endDate'] as String? ?? '2004-12-16'),
        //prepaId: json['idPrepa']['_id'] as String? ?? 'Aucune données cahrgé',
        //prepaName: json['idPrepa']['name'] as String? ?? 'Aucune données cahrgé',
        //prepaStartDate: json['idPrepa']['startDate'] as String? ?? 'Aucune données cahrgé'
    );
  }
}
