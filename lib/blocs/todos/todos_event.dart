import 'package:equatable/equatable.dart';
import 'package:super_enum/super_enum.dart';
import 'package:todo_list/models/todo.dart';

part 'todos_event.g.dart';

@superEnum
enum _TodoEvent {
  @object LoadTodos,
  @Data(fields: [DataField("todo", Todo),]) AddTodo,
  @Data(fields: [DataField("todo", Todo),]) UpdateTodo,
  @Data(fields: [DataField("todo", Todo),]) DeleteTodo,
  @object ClearCompleted,
  @object ToggleAll,
}
