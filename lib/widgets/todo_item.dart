import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/models/models.dart';

import 'keys.dart';

class TodoItem extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final ValueChanged<bool> onCheckboxChanged;
  final Todo todo;

  const TodoItem({
    @required this.onDismissed,
    @required this.onTap,
    @required this.onCheckboxChanged,
    @required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: WidgetKeys.todoItem(todo.id) as Key,
      onDismissed: onDismissed,
      child: ListTile(
        onTap: onTap,
        leading: Checkbox(
          key: WidgetKeys.todoItemCheckbox(todo.id) as Key,
          value: todo.complete,
          onChanged: onCheckboxChanged,
        ),
        title: Text(
          todo.description,
          key: WidgetKeys.todoItemTitle(todo.id) as Key,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          todo.note,
          key: WidgetKeys.todoItemNote(todo.id) as Key,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.subhead,
        ),
      ),
    );
  }
}
