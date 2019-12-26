import 'dart:collection';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_list/models/todo.dart';

class Todos extends Equatable {
  final UnmodifiableListView<Todo> items;

  Todos(Iterable<Todo> items)
      : items = UnmodifiableListView(items),
        assert(items != null);

  @override
  List<Object> get props => [items];

  Option<Todo> byId(int id) {
    Todo todo = items.firstWhere(
      (todo) => todo.id == id,
      orElse: () => null,
    );
    if (todo == null)
      return none<Todo>();
    else
      return Some(todo);
  }

  Todos add(Todo todo) => Todos(items + [todo]);

  Todos clearCompleted() => Todos(items.where((todo) => !todo.complete));

  Todos delete(Todo todo) => Todos(items.where((t) => t.id != todo.id));

  Todos toggleAll() {
    bool allCompleted = items.every((todo) => todo.complete);
    return Todos(items.map((todo) => todo.copyWith(complete: !allCompleted)));
  }

  Todos update(Todo todo) =>
      Todos(items.map((t) => t.id == todo.id ? todo : t));

  Todos where(Function1<Todo, bool> test) => Todos(items.where(test));

  @override
  String toString() => "\nTodos { _todos: [\n ${items.join(',\n ')}\n],}";
}
