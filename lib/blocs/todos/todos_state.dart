import 'package:super_enum/super_enum.dart';
import 'package:todo_list/models/todos.dart';

part "todos_state.g.dart";

@superEnum
enum _TodosState {
  @object TodosNotLoaded,
  @object TodosLoading,
  @Data(fields: [DataField("todos", Todos),]) TodosLoaded,
  @Data(fields: [DataField("message", String),]) TodosError,
}
