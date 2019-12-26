import "package:flutter_test/flutter_test.dart";
import 'package:todo_list/models/models.dart';

void main() {
  final dummy1 = Todo(
    id: 1,
    description: "Wash Dishes",
    date: DateTime(2010, 1, 1, 1, 1, 1).toString(),
    priority: Priority.high,
    complete: false,
    note: "",
  );
  final dummy2 = Todo(
    id: 2,
    description: "Make the bed",
    date: DateTime(2010, 1, 1, 1, 1, 1).toString(),
    priority: Priority.low,
    complete: true,
    note: "Do this Every morning!",
  );
  final Todos initialTodos = Todos([dummy1, dummy2]);

  test(
    "byTitle works",
    () async {
      // act
      final Todo actual = initialTodos.items.firstWhere(
        (todo) => todo.id == 1,
        orElse: () => null,
      );
      initialTodos.byId(1);

      // assert
      expect(actual, dummy1);
    },
  );

  test(
    "update works",
    () async {
      // arrange
      final todo = Todo(
        id: 1,
        description: "Wash Dishes",
        date: DateTime(2010, 1, 1, 1, 1, 1).toString(),
        priority: Priority.high,
        complete: true,
        note: "",
      );

      // act
      final actual = initialTodos.update(todo);

      // assert
      expect(actual.items, contains(todo));
      expect(actual.items, isNot(contains(dummy1)));
    },
  );

  test(
    "delete works",
    () async {
      // act
      final Todos actual = initialTodos.delete(dummy1);

      // assert
      expect(actual, isA<Todos>());
      expect(actual.items, isNot(contains(dummy1)));
    },
  );

  test(
    "clearCompleted works",
    () async {
      // act
      final Todos actual = initialTodos.clearCompleted();

      // assert
      expect(actual.items, actual.items.where((todo) => !todo.complete));
    },
  );
}
