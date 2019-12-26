import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  Failure(this.message);

  @override
  String toString() => message;
}

class DbFailure extends Failure {
  DbFailure(String message) : super(message);

  @override
  List<Object> get props => [message];
}

class HiveFailure extends DbFailure {
  HiveFailure(String message) : super(message);

  @override
  List<Object> get props => [message];
}

class MissingLocalizationMessageError extends Failure {
  MissingLocalizationMessageError(String message) : super(message);

  @override
  List<Object> get props => [message];
}

class UnsupportedLocale extends Failure {
  UnsupportedLocale(String message) : super(message);

  @override
  List<Object> get props => [message];
}