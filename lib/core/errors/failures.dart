
sealed class Failure {
  final String message;
  Failure(this.message);
}

class ServerFailure extends Failure {
  final int statusCode;
  ServerFailure(this.statusCode, super.message);
}

class UnauthorizedFailure extends Failure {
  UnauthorizedFailure() : super('Email ou mot de passe incorrect');
}

class NetworkFailure extends Failure {
  NetworkFailure() : super('Aucune connexion Internet');
}