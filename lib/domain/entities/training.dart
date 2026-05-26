class Training {
  final String id;
  final DateTime startDate;
  final DateTime endDate;
  final String description;

  Training({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.description,
  });

  factory Training.fromApi(Map<String, dynamic> json) {
    return Training(
      id: json['_id'] as String? ?? 'Aucune données cahrgé',
      startDate: DateTime.parse(json['startDate'] as String? ?? '2004-12-16'),
      endDate: DateTime.parse(json['endDate'] as String? ?? '2004-12-16'),
      description: json['description'] as String? ?? 'Aucune données cahrgé',
    );
  }
}
