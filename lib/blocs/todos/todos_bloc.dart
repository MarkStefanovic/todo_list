import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_list/blocs/todos/todos_event.dart';
import 'package:todo_list/blocs/todos/todos_state.dart';
import 'package:todo_list/errors.dart';
import 'package:todo_list/models/models.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/services/todo_repository.dart';

//@formatter:off
class TodosBloc extends Bloc<TodoEvent, TodosState> {
  final TodoRepository repository;

  TodosBloc(this.repository);

  @override
  TodosState get initialState => TodosState.todosNotLoaded();

  @override
  Stream<TodosState> mapEventToState(TodoEvent event) async* {
    yield* event.when(
      loadTodos: (_) => _handleLoadTodos(),
      addTodo: (event) => _handleAddTodo(event),
      updateTodo: (event) => _handleUpdateTodo(event),
      deleteTodo: (event) => _handleDeleteTodo(event),
      clearCompleted: (_) => _handleClearCompleted(),
      toggleAll: (_) => _handleToggleAll(),
    );
  }

  Stream<TodosState> _handleLoadTodos() async* {
    yield TodosState.todosLoading();
    final Either<Failure, Todos> result = await repository.all();
    debugPrint("result = $result");
    yield result.fold(
      (failure) => TodosState.todosError(message: failure.message),
      (todos) => TodosState.todosLoaded(todos: todos),
    );
  }

  Stream<TodosState> _handleAddTodo(AddTodo event) async* {
    final Either<Failure, Todo> result = await repository.add(event.todo);
    final TodosState newState = result.fold(
      (failure) => TodosState.todosError(message: failure.message),
      (todo) {
        return state.when(
          todosNotLoaded: (_) => TodosState.todosError(
            message: "Attempted to add an item before it was loaded.",
          ),
          todosLoading: (_) => TodosState.todosError(
            message: "Attempted to add an item while items were still loading.",
          ),
          todosLoaded: (loadedState) {
            final Todos updatedTodos = loadedState.todos.add(todo);
            return TodosState.todosLoaded(todos: updatedTodos);
          },
          todosError: (errorState) => errorState,
        );
      },
    );
    yield newState;
  }

  Stream<TodosState> _handleDeleteTodo(DeleteTodo event) async* {
    final Either<Failure, Todo> result = await repository.delete(event.todo);
    final TodosState newState = result.fold(
      (failure) => TodosState.todosError(message: failure.message),
      (todo) {
        return state.when(
          todosNotLoaded: (_) => TodosState.todosError(
            message: "Attempted to delete an item before the items were loaded.",
          ),
          todosLoading: (_) => TodosState.todosError(
            message:
                "Attempted to delete an item while items were still loading.",
          ),
          todosLoaded: (loadedState) {
            final Todos updatedTodos = loadedState.todos.delete(todo);
            return TodosState.todosLoaded(todos: updatedTodos);
          },
          todosError: (errorState) => errorState,
        );
      },
    );
    yield newState;
  }

  Stream<TodosState> _handleUpdateTodo(UpdateTodo event) async* {
    final Either<Failure, Todo> result = await repository.update(event.todo);
    final TodosState newState = result.fold(
      (failure) => TodosState.todosError(message: failure.message),
      (todo) {
        return state.when(
          todosNotLoaded: (_) => TodosState.todosError(
            message: "Attempted to update an item before it was loaded.",
          ),
          todosLoading: (_) => TodosState.todosError(
            message:
                "Attempted to update an item while items were still loading.",
          ),
          todosLoaded: (loadedState) {
            final Todos updatedTodos = loadedState.todos.update(event.todo);
            return TodosState.todosLoaded(todos: updatedTodos);
          },
          todosError: (errorState) => errorState,
        );
      },
    );
    yield newState;
  }

  Stream<TodosState> _handleClearCompleted() async* {
    final Either<Failure, Todos> result = await repository.clearCompleted();
    final TodosState newState = result.fold(
      (failure) => TodosState.todosError(message: failure.message),
      (todo) {
        return state.when(
          todosNotLoaded: (_) => TodosState.todosError(
            message: "Attempted to update an item before it was loaded.",
          ),
          todosLoading: (_) => TodosState.todosError(
            message:
                "Attempted to update an item while items were still loading.",
          ),
          todosLoaded: (loadedState) {
            final Todos uncompleted =
                loadedState.todos.where((todo) => !todo.complete);
            return TodosState.todosLoaded(todos: uncompleted);
          },
          todosError: (errorState) => errorState,
        );
      },
    );
    yield newState;
  }

  Stream<TodosState> _handleToggleAll() async* {
    final Either<Failure, Todos> result = await repository.toggleAll();
    final TodosState newState = result.fold(
      (failure) => TodosState.todosError(message: failure.message),
      (todo) {
        return state.when(
          todosNotLoaded: (_) => TodosState.todosError(
            message: "Attempted to toggle items before they were loaded.",
          ),
          todosLoading: (_) => TodosState.todosError(
            message: "Attempted to toggle items while they were still loading.",
          ),
          todosLoaded: (loadedState) {
            final updatedTodos = loadedState.todos.toggleAll();
            return TodosState.todosLoaded(todos: updatedTodos);
          },
          todosError: (errorState) => errorState,
        );
      },
    );
    yield newState;
  }
}
//@formatter:on
