// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todos_state.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class TodosState extends Equatable {
  const TodosState(this._type);

  factory TodosState.todosNotLoaded() = TodosNotLoaded;

  factory TodosState.todosLoading() = TodosLoading;

  factory TodosState.todosLoaded({@required Todos todos}) = TodosLoaded;

  factory TodosState.todosError({@required String message}) = TodosError;

  final _TodosState _type;

//ignore: missing_return
  R when<R>(
      {@required R Function(TodosNotLoaded) todosNotLoaded,
      @required R Function(TodosLoading) todosLoading,
      @required R Function(TodosLoaded) todosLoaded,
      @required R Function(TodosError) todosError}) {
    switch (this._type) {
      case _TodosState.TodosNotLoaded:
        return todosNotLoaded(this as TodosNotLoaded);
      case _TodosState.TodosLoading:
        return todosLoading(this as TodosLoading);
      case _TodosState.TodosLoaded:
        return todosLoaded(this as TodosLoaded);
      case _TodosState.TodosError:
        return todosError(this as TodosError);
    }
  }

  @override
  List get props => [];
}

@immutable
class TodosNotLoaded extends TodosState {
  const TodosNotLoaded._() : super(_TodosState.TodosNotLoaded);

  factory TodosNotLoaded() {
    _instance ??= TodosNotLoaded._();
    return _instance;
  }

  static TodosNotLoaded _instance;
}

@immutable
class TodosLoading extends TodosState {
  const TodosLoading._() : super(_TodosState.TodosLoading);

  factory TodosLoading() {
    _instance ??= TodosLoading._();
    return _instance;
  }

  static TodosLoading _instance;
}

@immutable
class TodosLoaded extends TodosState {
  const TodosLoaded({@required this.todos}) : super(_TodosState.TodosLoaded);

  final Todos todos;

  @override
  String toString() => 'TodosLoaded(todos:${this.todos})';
  @override
  List get props => [todos];
}

@immutable
class TodosError extends TodosState {
  const TodosError({@required this.message}) : super(_TodosState.TodosError);

  final String message;

  @override
  String toString() => 'TodosError(message:${this.message})';
  @override
  List get props => [message];
}
