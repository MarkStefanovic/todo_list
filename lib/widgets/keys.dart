import 'package:flutter/foundation.dart';

class WidgetKeys {
  static final todoDetailsWidget = Key("__todoDetailWidget__");

  static var saveTodoFab = Key("__saveTodoFab__");

  static var saveNewTodo = Key("__saveNewTodo__");

  static var emptyDetailsContainer = Key("__emptyDetailsContainer__");

  static var deleteTodoButton = Key("__deleteTodoButton__");

  static var todoDetailsCheckBox = Key("__todoDetailsCheckBox__");

  static var todoTitle = Key("__todoTitle__");

  static var todoNote = Key("__todoNote__");

  static var editTodoScreen = Key("__editTodoScreen__");

  static var editTodoFab = Key("__editTodoFab__");

  static var addTodoPage = Key("__addTodoPage__");

  static var titleField = Key("__titleField__");

  static var noteField = Key("__noteField__");

  static var loadingSpinner = Key("__loadingSpinner__");

  static var addTodoButton = Key("__addTodoButton__");

  static var todoListView = Key("__todoListView__");

  static var todoList = Key("__todoList__");

  static todoItem(int id) => Key("__TodoItem__$id");

  static todoItemTitleField(int id) => Key("__TodoItemTitleField__$id");

  static todoItemCheckbox(int id) => Key("__todoItemCheckbox__$id");

  static todoItemTitle(int id) => Key("__todoItemTitle__$id");

  static todoItemNote(int id) => Key("__todoItemNote__$id");

  static todoItemDeleteButton(int id) => Key("__todoItemDeleteButton__$id");
}
