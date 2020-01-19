import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:flutter_test/flutter_test.dart";
import "package:mockito/mockito.dart";
import 'package:todo_list/blocs/blocs.dart';
import 'package:todo_list/localization.dart';
import 'package:todo_list/models/models.dart';
import 'package:todo_list/widgets/widgets.dart';

class MockTodosBloc extends MockBloc<TodoEvent, TodosState>
    implements TodosBloc {}

void main() {
  group("todo_list view", () {
    TodosBloc todosBloc;

    setUp(() {
      todosBloc = MockTodosBloc();
    });

    Future<void> loadTodoList(WidgetTester tester, Todos todos) async {
      when(todosBloc.state).thenReturn(
        TodosState.todosLoaded(todos: todos),
      );
      await tester.pumpWidget(BlocProvider.value(
        value: todosBloc,
        child: MaterialApp(
          home: Scaffold(
            body: TodoList(),
          ),
          localizationsDelegates: [
            AppLocalizations.delegate,
          ],
        ),
      ));
      await tester.pumpAndSettle();
    }

    testWidgets("displays an add button", (WidgetTester tester) async {
      await loadTodoList(tester, Todos([]));
      expect(find.byKey(WidgetKeys.addTodoButton), findsOneWidget);
    });

    testWidgets(
      "displays todos provided by the bloc",
      (WidgetTester tester) async {
        await loadTodoList(
          tester,
          Todos([
            Todo(
              id: 1,
              description: "Make Bed",
              date: "2019-01-01",
              priority: Priority.low,
              complete: false,
              note: "",
            ),
            Todo(
              id: 2,
              description: "Wash Dishes",
              date: "2019-01-02",
              priority: Priority.high,
              complete: false,
              note: "",
            ),
          ]),
        );
        expect(find.byKey(WidgetKeys.todoItem(1) as Key), findsOneWidget);
        expect(find.byKey(WidgetKeys.todoItem(2) as Key), findsOneWidget);
      },
    );

    testWidgets(
      "delete button removes todo from list",
      (WidgetTester tester) async {
        final todo = Todo(
          id: 1,
          description: "Make Bed",
          date: "2019-01-01",
          priority: Priority.low,
          complete: false,
          note: "",
        );
        await loadTodoList(tester, Todos([todo]));
        expect(find.byKey(WidgetKeys.todoItemDeleteButton(1) as Key), findsOneWidget);
        expect(find.byKey(WidgetKeys.todoList), findsOneWidget);
        await tester.tap(find.byKey(WidgetKeys.todoItemDeleteButton(1) as Key));
        verify(todosBloc.add(TodoEvent.deleteTodo(todo: todo))).called(1);
      },
    );
  });
}
