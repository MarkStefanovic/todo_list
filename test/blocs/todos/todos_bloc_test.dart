import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import "package:flutter_test/flutter_test.dart";
import "package:mockito/mockito.dart";
import 'package:todo_list/blocs/blocs.dart';
import 'package:todo_list/errors.dart';
import 'package:todo_list/models/models.dart';
import 'package:todo_list/services/todo_repository.dart';

class MockTodoRepository extends Mock implements TodoRepository {}

void main() {
  MockTodoRepository mockTodoRepository;
  final initialTodos = Todos([
    Todo(
      id: 1,
      description: "Wash Dishes",
      date: DateTime(2010, 1, 1, 1, 1, 1).toString(),
      priority: Priority.high,
      complete: false,
      note: "",
    ),
    Todo(
      id: 2,
      description: "Make the bed",
      date: DateTime(2010, 1, 1, 1, 1, 1).toString(),
      priority: Priority.low,
      complete: true,
      note: "Do this Every morning!",
    ),
  ]);

  setUp(() {
    mockTodoRepository = MockTodoRepository();
  });

  group("loadTodos", () {
    blocTest(
      "loadTodos emits TodosLoaded when successful",
      build: () {
        when(mockTodoRepository.all())
            .thenAnswer((_) async => Right(initialTodos));
        return TodosBloc(mockTodoRepository);
      },
      act: (bloc) async => bloc.add(TodoEvent.loadTodos()),
      expect: [
        TodosState.todosNotLoaded(),
        TodosState.todosLoading(),
        TodosLoaded(todos: initialTodos),
      ],
    );

    blocTest(
      "loadTodos emits TodosError when unsuccessful",
      build: () {
        when(mockTodoRepository.all()).thenAnswer(
          (_) async => Left(
            HiveFailure("An error occurred while reading from the database."),
          ),
        );
        return TodosBloc(mockTodoRepository);
      },
      act: (bloc) async => bloc.add(TodoEvent.loadTodos()),
      expect: [
        TodosState.todosNotLoaded(),
        TodosState.todosLoading(),
        TodosState.todosError(
          message: "An error occurred while reading from the database.",
        ),
      ],
    );
  });

  group("addTodo", () {
    final todo = Todo(
      id: 3,
      description: "Make Bed",
      date: DateTime(2010, 1, 1, 1, 1, 1).toString(),
      priority: Priority.high,
      complete: false,
      note: "Remember to fluff the pillows.",
    );

    blocTest(
      "addTodo emits TodosLoaded when successful",
      build: () {
        when(mockTodoRepository.all())
            .thenAnswer((_) async => Right(initialTodos));
        when(mockTodoRepository.add(todo)).thenAnswer((_) async => Right(todo));
        return TodosBloc(mockTodoRepository);
      },
      act: (bloc) async {
        bloc.add(TodoEvent.loadTodos());
        bloc.add(TodoEvent.addTodo(todo: todo));
      },
      expect: [
        TodosState.todosNotLoaded(),
        TodosState.todosLoading(),
        TodosLoaded(todos: initialTodos),
        TodosLoaded(todos: initialTodos.add(todo)),
      ],
    );

    blocTest(
      "addTodo emits TodosError when unsuccessful",
      build: () {
        when(mockTodoRepository.add(any)).thenAnswer(
          (_) async => Left(
            HiveFailure("An error occurred while reading from the database."),
          ),
        );
        return TodosBloc(mockTodoRepository);
      },
      act: (bloc) async {
        bloc.add(TodoEvent.loadTodos());
        bloc.add(TodoEvent.addTodo(todo: todo));
      },
      expect: [
        TodosState.todosNotLoaded(),
        TodosState.todosLoading(),
        TodosError(
          message: "An error occurred while reading from the database.",
        ),
      ],
    );
  });

  group("updateTodo", () {
    final updatedTodo = Todo(
      id: 1,
      description: "Wash Dishes",
      date: DateTime(2010, 1, 1, 1, 1, 1).toString(),
      priority: Priority.high,
      complete: false,
      note: "Make them shine!",
    );
    blocTest(
      "updateTodo emits TodosLoaded when successful",
      build: () {
        when(mockTodoRepository.all())
            .thenAnswer((_) async => Right(initialTodos));
        when(mockTodoRepository.update(updatedTodo))
            .thenAnswer((_) async => Right(updatedTodo));
        return TodosBloc(mockTodoRepository);
      },
      act: (bloc) async {
        bloc.add(TodoEvent.loadTodos());
        bloc.add(TodoEvent.updateTodo(todo: updatedTodo));
      },
      expect: [
        TodosState.todosNotLoaded(),
        TodosState.todosLoading(),
        TodosState.todosLoaded(todos: initialTodos),
        TodosState.todosLoaded(todos: initialTodos.update(updatedTodo)),
      ],
    );

    blocTest(
      "updateTodo emits TodosError when unsuccessful",
      build: () {
        when(mockTodoRepository.all())
            .thenAnswer((_) async => Right(initialTodos));
        when(mockTodoRepository.update(any)).thenAnswer(
          (_) async => Left(
            HiveFailure("An error occurred while reading from the database."),
          ),
        );
        return TodosBloc(mockTodoRepository);
      },
      act: (bloc) async {
        bloc.add(TodoEvent.loadTodos());
        bloc.add(TodoEvent.updateTodo(todo: updatedTodo));
      },
      expect: [
        TodosState.todosNotLoaded(),
        TodosState.todosLoading(),
        TodosState.todosLoaded(todos: initialTodos),
        TodosState.todosError(
          message: "An error occurred while reading from the database.",
        ),
      ],
    );
  });

  group("deleteTodo", () {
    final Todo toDelete = initialTodos.items.firstWhere(
      (todo) => todo.id == 1,
      orElse: () => null,
    );

    blocTest(
      "deleteTodo emits TodosLoaded when successful",
      build: () {
        when(mockTodoRepository.all())
            .thenAnswer((_) async => Right(initialTodos));
        when(mockTodoRepository.delete(toDelete))
            .thenAnswer((_) async => Right(toDelete));
        return TodosBloc(mockTodoRepository);
      },
      act: (bloc) async {
        bloc.add(TodoEvent.loadTodos());
        bloc.add(TodoEvent.deleteTodo(todo: toDelete));
      },
      expect: [
        TodosState.todosNotLoaded(),
        TodosState.todosLoading(),
        TodosState.todosLoaded(todos: initialTodos),
        TodosState.todosLoaded(todos: initialTodos.delete(toDelete)),
      ],
    );

    blocTest(
      "deleteTodo emits TodosError when unsuccessful",
      build: () {
        when(mockTodoRepository.all())
            .thenAnswer((_) async => Right(initialTodos));
        when(mockTodoRepository.delete(toDelete)).thenAnswer(
          (_) async => Left(
            HiveFailure("An error occurred while reading from the database."),
          ),
        );
        return TodosBloc(mockTodoRepository);
      },
      act: (bloc) async {
        bloc.add(TodoEvent.loadTodos());
        bloc.add(TodoEvent.deleteTodo(todo: toDelete));
      },
      expect: [
        TodosState.todosNotLoaded(),
        TodosState.todosLoading(),
        TodosState.todosLoaded(todos: initialTodos),
        TodosState.todosError(
          message: "An error occurred while reading from the database.",
        ),
      ],
    );
  });

  group("clearCompleted", () {
    blocTest(
      "clearCompleted emits TodosLoaded when successful",
      build: () {
        when(mockTodoRepository.all())
            .thenAnswer((_) async => Right(initialTodos));
        when(mockTodoRepository.clearCompleted())
            .thenAnswer((_) async => Right(initialTodos.clearCompleted()));
        return TodosBloc(mockTodoRepository);
      },
      act: (bloc) async {
        bloc.add(TodoEvent.loadTodos());
        bloc.add(TodoEvent.clearCompleted());
      },
      expect: [
        TodosState.todosNotLoaded(),
        TodosState.todosLoading(),
        TodosState.todosLoaded(todos: initialTodos),
        TodosState.todosLoaded(todos: initialTodos.clearCompleted()),
      ],
    );

    blocTest(
      "clearCompleted emits TodosError when unsuccessful",
      build: () {
        when(mockTodoRepository.all())
            .thenAnswer((_) async => Right(initialTodos));
        when(mockTodoRepository.clearCompleted()).thenAnswer(
          (_) async => Left(
            HiveFailure("An error occurred while reading from the database."),
          ),
        );
        return TodosBloc(mockTodoRepository);
      },
      act: (bloc) async {
        bloc.add(TodoEvent.loadTodos());
        bloc.add(TodoEvent.clearCompleted());
      },
      expect: [
        TodosState.todosNotLoaded(),
        TodosState.todosLoading(),
        TodosState.todosLoaded(todos: initialTodos),
        TodosState.todosError(
          message: "An error occurred while reading from the database.",
        ),
      ],
    );
  });

  group("toggleAll", () {
    blocTest(
      "toggleAll emits TodosLoaded when successful",
      build: () {
        when(mockTodoRepository.all())
            .thenAnswer((_) async => Right(initialTodos));
        when(mockTodoRepository.toggleAll())
            .thenAnswer((_) async => Right(initialTodos.toggleAll()));
        return TodosBloc(mockTodoRepository);
      },
      act: (bloc) async {
        bloc.add(TodoEvent.loadTodos());
        bloc.add(TodoEvent.toggleAll());
      },
      expect: [
        TodosState.todosNotLoaded(),
        TodosState.todosLoading(),
        TodosState.todosLoaded(todos: initialTodos),
        TodosState.todosLoaded(todos: initialTodos.toggleAll()),
      ],
    );

    blocTest(
      "toggleAll emits TodosError when unsuccessful",
      build: () {
        when(mockTodoRepository.all())
            .thenAnswer((_) async => Right(initialTodos));
        when(mockTodoRepository.toggleAll()).thenAnswer(
          (_) async => Left(
            HiveFailure("An error occurred while reading from the database."),
          ),
        );
        return TodosBloc(mockTodoRepository);
      },
      act: (bloc) async {
        bloc.add(TodoEvent.loadTodos());
        bloc.add(TodoEvent.toggleAll());
      },
      expect: [
        TodosState.todosNotLoaded(),
        TodosState.todosLoading(),
        TodosState.todosLoaded(todos: initialTodos),
        TodosState.todosError(
          message: "An error occurred while reading from the database.",
        ),
      ],
    );
  });
}
