part of 'user_race_bloc.dart';

@immutable
sealed class UserRaceEvent {}

final class LoadUserRaces extends UserRaceEvent {
  final bool isActiveRaces;
  LoadUserRaces({required this.isActiveRaces});
}

class TogglePastRaceDisplayed extends UserRaceEvent {}
