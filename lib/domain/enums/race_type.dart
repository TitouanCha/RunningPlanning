enum RaceType {
  fiveK('5K'),
  tenK('10K'),
  semi('Semi'),
  marathon('Marathon'),
  trail('Trail'),
  other('Other');

  final String label;
  const RaceType(this.label);

  static RaceType fromString(String value) {
    return RaceType.values.firstWhere(
      (e) => e.label.toLowerCase() == value.toLowerCase(),
      orElse: () => RaceType.other,
    );
  }
}