import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_list/errors.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/models/todos.dart';

abstract class TodoRepository {
  Future<Either<DbFailure, Todos>> all();

  Future<Either<DbFailure, Todo>> add(Todo todo);

  Future<Either<DbFailure, Todo>> update(Todo todo);

  Future<Either<DbFailure, Todo>> delete(Todo todo);

  Future<Option<Todo>> get(int id);

  Future<Either<DbFailure, Todos>> toggleAll();

  Future<Either<DbFailure, Todos>> clearCompleted();

  Future<Either<DbFailure, int>> count();
}

class TodoHiveRepository implements TodoRepository {
  final Box<Todo> box = Hive.box("todos");

  @override
  Future<Either<HiveFailure, Todos>> all() async {
    debugPrint("called all()");
    try {
      if (box.isEmpty) {
        debugPrint("box is empty");
        return Right(Todos(const []));
      } else {
        return Right(Todos(box.values.cast<Todo>()));
      }
    } catch (e) {
      debugPrint(e.toString());
      return Left(HiveFailure(e.toString()));
    }
  }

  @override
  Future<Either<HiveFailure, Todo>> add(Todo todo) async {
    debugPrint("called add(todo: $todo)");
    try {
      final newId = await box.add(todo);
      return Right(todo.copyWith(id: newId));
    } catch (e) {
      debugPrint(e.toString());
      return Left(HiveFailure(e.toString()));
    }
  }

  @override
  Future<Either<HiveFailure, Todo>> update(Todo todo) async {
    debugPrint("called update(todo: $todo)");
    try {
      await box.put(todo.id, todo);
      return Right(todo);
    } catch (e) {
      debugPrint(e.toString());
      return Left(HiveFailure(e.toString()));
    }
  }

  @override
  Future<Either<HiveFailure, Todo>> delete(Todo todo) async {
    debugPrint("called delete(todo: $todo)");
    try {
      await box.delete(todo.id);
      return Right(todo);
    } catch (e) {
      debugPrint(e.toString());
      return Left(HiveFailure(e.toString()));
    }
  }

  @override
  Future<Option<Todo>> get(int id) async {
    debugPrint("called get(id: $id)");
    try {
      return some(box.get(id));
    } catch (e) {
      debugPrint(e.toString());
      return none();
    }
  }

  @override
  Future<Either<HiveFailure, Todos>> toggleAll() async {
    debugPrint("called toggleAll()");
    try {
      final todos = box.values;
      final bool allComplete = todos.every((todo) => todo.complete);
      bool from;
      if (allComplete) {
        from = true;
      } else {
        from = false;
      }
      final bool to = !from;
      todos.forEach((todo) {
        if (todo.complete == from) {
          todo.complete = to;
          todo.save();
        }
      });
      return Right(Todos(todos));
    } catch (e) {
      debugPrint(e.toString());
      return Left(HiveFailure(e.toString()));
    }
  }

  @override
  Future<Either<HiveFailure, Todos>> clearCompleted() async {
    debugPrint("called clearCompleted()");
    try {
      box.values.forEach((todo) {
        if (todo.complete) {
          box.delete(todo.id);
        }
      });
      return Right(Todos(box.values.cast<Todo>()));
    } catch (e) {
      debugPrint(e.toString());
      return Left(HiveFailure(e.toString()));
    }
  }

  @override
  Future<Either<HiveFailure, int>> count() async {
    debugPrint("called count()");
    try {
      return Right(box.length);
    } catch (e) {
      debugPrint("An error occured while calling count(): $e");
      return Left(HiveFailure(e.toString()));
    }
  }
}
