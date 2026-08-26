
import 'package:intl/intl.dart';

class AddStepModel {
  final String name;
  final String description;
  final DateTime startDate;
  final DateTime endDate;

  AddStepModel({
    required this.name,
    required this.description,
    required this.startDate,
    required this.endDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'startDate': DateFormat('dd/MM/yyyy').format(startDate),
      'endDate': DateFormat('dd/MM/yyyy').format(endDate),
    };
  }
}