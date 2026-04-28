enum RaceType {
  fiveK('5K'),
  tenK('10K'),
  semi('Semi'),
  marathon('Marathon'),
  trail('Trail'),
  other('Other');

  final String label;
  const RaceType(this.label);
}
