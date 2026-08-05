part of 'user_race_bloc.dart';

enum UserRaceStatus { initial, loadingNextRace, loadingPastRace , success, error }
class UserRaceState {
  final UserRaceStatus status;
  final List<Prepa> userNextPrepa;
  final List<Prepa> userPastPrepa;
  final bool isPastRaceDisplayed;
  final String? errorMessage;

  const UserRaceState({
    this.status = UserRaceStatus.initial,
    this.userNextPrepa = const [],
    this.userPastPrepa = const [],
    this.isPastRaceDisplayed = false,
    this.errorMessage,
  });

  UserRaceState copyWith({
    UserRaceStatus? status,
    List<Prepa>? userNextPrepa,
    List<Prepa>? userPastPrepa,
    bool? isPastRaceDisplayed,
    String? errorMessage,
  }) {
    return UserRaceState(
      status: status ?? this.status,
      userNextPrepa: userNextPrepa ?? this.userNextPrepa,
      userPastPrepa: userPastPrepa ?? this.userPastPrepa,
      isPastRaceDisplayed: isPastRaceDisplayed ?? this.isPastRaceDisplayed,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

