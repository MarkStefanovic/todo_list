import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart';
import 'package:todo_list/models/models.dart';
import 'package:todo_list/services/todo_repository.dart';

void main() {
  TodoRepository todoRepository;
  Box todoBox;
  List<Todo> originalTodos = [
    Todo(
      id: 1,
      description: "Wash Dishes",
      date: DateTime(2010, 1, 1).toString(),
      priority: Priority.low,
      complete: false,
      note: "",
    ),
    Todo(
      id: 2,
      description: "Make the bed",
      date: DateTime(2010, 1, 2).toString(),
      priority: Priority.high,
      complete: true,
      note: "Do this Every morning!",
    ),
  ];

  setUpAll(() async {
    Hive.registerAdapter(PriorityAdapter(), 0);
    Hive.registerAdapter(TodoAdapter(), 1);
  });

  setUp(() async {
    final Directory folder = await Directory.systemTemp.createTemp("fixtures");
    final fp = join(folder.path, "test", "fixtures");
    Hive.init(fp);
    todoBox = await Hive.openBox<Todo>("todos");
    todoRepository = TodoHiveRepository();
  });

  tearDown(() {
    Hive.deleteFromDisk();
    Hive.close();
  });

  group("when add is called the item should be added to the box", () {
    test(
      "test add",
      () async {
        // arrange
        originalTodos.forEach((todo) async => await todoBox.put(todo.id, todo));
        final todo = Todo(
          id: 3,
          description: "Mow Lawn",
          date: DateTime(2010, 10, 3).toString(),
          priority: Priority.high,
          complete: false,
          note: "",
        );

        // act
        expect(null, todoBox.get(3));
        await todoRepository.add(todo);

        // assert
        Todo actual = todoBox.get(3);
        expect(actual, todo);
      },
    );

    test(
      "all returns Todos wrapping an empty list when the box is empty",
      () async {
        // act
        final items = await todoRepository.all();

        // assert
        expect(items, Right(Todos([])));
      },
    );
  });
}
