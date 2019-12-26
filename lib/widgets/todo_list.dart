import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/blocs/blocs.dart';
import 'package:todo_list/localization.dart';
import 'package:todo_list/models/models.dart';
import 'package:todo_list/routes.dart';
import 'package:todo_list/widgets/keys.dart';
import 'package:todo_list/widgets/loading.dart';

import 'add_edit_page.dart';
import 'alert.dart';

class TodoList extends StatelessWidget {
  TodoList({Key key}) : super(key: key ?? WidgetKeys.todoListView);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return BlocBuilder<TodosBloc, TodosState>(
      bloc: BlocProvider.of<TodosBloc>(context),
      builder: (context, state) {
        return state.when(
          todosNotLoaded: (_) => Container(
            key: WidgetKeys.emptyDetailsContainer,
          ),
          todosLoading: (_) => LoadingSpinner(),
          todosError: (errorState) {
            return Alert(message: errorState.message);
          },
          todosLoaded: (loadedState) {
            return Scaffold(
              appBar: AppBar(
                title: Text(localizations.todoDetailsAppBarTitle),
                actions: <Widget>[
                  IconButton(
                    tooltip: localizations.addTodoButtonTooltip,
                    key: WidgetKeys.addTodoButton,
                    icon: Icon(Icons.add),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        Routes.addEditPage,
                        arguments: AddEditPageArguments(
                          onSave: (description, note) async {
                            final newTodo = Todo(
                              id: -1,
                              description: description,
                              date: DateTime.now().toString(),
                              priority: Priority.high,
                              complete: false,
                              note: note,
                            );
                            BlocProvider.of<TodosBloc>(context)
                                .add(TodoEvent.addTodo(todo: newTodo));
                          },
                          todo: dummyTodo,
                          isEditing: false,
                        ),
                      );
                      return AddEditPage(
                        key: WidgetKeys.editTodoScreen,
                        onSave: (description, note) {
                          final todo = Todo(
                            id: -1,
                            description: description,
                            date: DateTime.now().toString(),
                            priority: Priority.high,
                            complete: false,
                            note: note,
                          );
                          BlocProvider.of<TodosBloc>(context)
                              .add(TodoEvent.addTodo(todo: todo));
                        },
                        isEditing: true,
                        todo: dummyTodo,
                      );
                    },
                  ),
                ],
              ),
              body: ListView.builder(
                key: WidgetKeys.todoList,
                itemCount: loadedState.todos.items.length,
                itemBuilder: (context, index) {
                  final todo = loadedState.todos.items[index];

                  return Dismissible(
                    key: WidgetKeys.todoItem(todo.id),
                    background: Container(color: Colors.red),
                    onDismissed: (direction) {
                      BlocProvider.of<TodosBloc>(context).add(
                        TodoEvent.deleteTodo(todo: todo),
                      );
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text("${todo.description} deleted."),
                        ),
                      );
                    },
                    child: Card(
                      child: ListTile(
                        leading: IconButton(
                          icon: Icon(Icons.expand_more),
                          onPressed: () {
                            debugPrint("expand_more button clicked");
                          },
                        ),
                        title: Text(todo.description),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.addEditPage,
                            arguments: AddEditPageArguments(
                              todo: todo,
                              onSave: (description, note) {
                                BlocProvider.of<TodosBloc>(context).add(
                                  TodoEvent.updateTodo(
                                    todo: todo.copyWith(
                                      description: description,
                                      note: note,
                                    ),
                                  ),
                                );
                              },
                              isEditing: true,
                            ),
                          );
                        },
                        trailing: IconButton(
                          key: WidgetKeys.todoItemDeleteButton(todo.id),
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            BlocProvider.of<TodosBloc>(context).add(
                              TodoEvent.deleteTodo(todo: todo),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
