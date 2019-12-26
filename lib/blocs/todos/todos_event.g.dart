// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todos_event.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class TodoEvent extends Equatable {
  const TodoEvent(this._type);

  factory TodoEvent.loadTodos() = LoadTodos;

  factory TodoEvent.addTodo({@required Todo todo}) = AddTodo;

  factory TodoEvent.updateTodo({@required Todo todo}) = UpdateTodo;

  factory TodoEvent.deleteTodo({@required Todo todo}) = DeleteTodo;

  factory TodoEvent.clearCompleted() = ClearCompleted;

  factory TodoEvent.toggleAll() = ToggleAll;

  final _TodoEvent _type;

//ignore: missing_return
  R when<R>(
      {@required R Function(LoadTodos) loadTodos,
      @required R Function(AddTodo) addTodo,
      @required R Function(UpdateTodo) updateTodo,
      @required R Function(DeleteTodo) deleteTodo,
      @required R Function(ClearCompleted) clearCompleted,
      @required R Function(ToggleAll) toggleAll}) {
    switch (this._type) {
      case _TodoEvent.LoadTodos:
        return loadTodos(this as LoadTodos);
      case _TodoEvent.AddTodo:
        return addTodo(this as AddTodo);
      case _TodoEvent.UpdateTodo:
        return updateTodo(this as UpdateTodo);
      case _TodoEvent.DeleteTodo:
        return deleteTodo(this as DeleteTodo);
      case _TodoEvent.ClearCompleted:
        return clearCompleted(this as ClearCompleted);
      case _TodoEvent.ToggleAll:
        return toggleAll(this as ToggleAll);
    }
  }

  @override
  List get props => [];
}

@immutable
class LoadTodos extends TodoEvent {
  const LoadTodos._() : super(_TodoEvent.LoadTodos);

  factory LoadTodos() {
    _instance ??= LoadTodos._();
    return _instance;
  }

  static LoadTodos _instance;
}

@immutable
class AddTodo extends TodoEvent {
  const AddTodo({@required this.todo}) : super(_TodoEvent.AddTodo);

  final Todo todo;

  @override
  String toString() => 'AddTodo(todo:${this.todo})';
  @override
  List get props => [todo];
}

@immutable
class UpdateTodo extends TodoEvent {
  const UpdateTodo({@required this.todo}) : super(_TodoEvent.UpdateTodo);

  final Todo todo;

  @override
  String toString() => 'UpdateTodo(todo:${this.todo})';
  @override
  List get props => [todo];
}

@immutable
class DeleteTodo extends TodoEvent {
  const DeleteTodo({@required this.todo}) : super(_TodoEvent.DeleteTodo);

  final Todo todo;

  @override
  String toString() => 'DeleteTodo(todo:${this.todo})';
  @override
  List get props => [todo];
}

@immutable
class ClearCompleted extends TodoEvent {
  const ClearCompleted._() : super(_TodoEvent.ClearCompleted);

  factory ClearCompleted() {
    _instance ??= ClearCompleted._();
    return _instance;
  }

  static ClearCompleted _instance;
}

@immutable
class ToggleAll extends TodoEvent {
  const ToggleAll._() : super(_TodoEvent.ToggleAll);

  factory ToggleAll() {
    _instance ??= ToggleAll._();
    return _instance;
  }

  static ToggleAll _instance;
}
