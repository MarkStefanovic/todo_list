import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  String toString() => message;
}

class DbFailure extends Failure {
  const DbFailure(String message) : super(message);

  @override
  List<Object> get props => [message];
}

class HiveFailure extends DbFailure {
  const HiveFailure(String message) : super(message);

  @override
  List<Object> get props => [message];
}

class MissingLocalizationMessageError extends Failure {
  const MissingLocalizationMessageError(String message) : super(message);

  @override
  List<Object> get props => [message];
}

class UnsupportedLocale extends Failure {
  const UnsupportedLocale(String message) : super(message);

  @override
  List<Object> get props => [message];
}