import 'package:get_it/get_it.dart';
import 'package:todo_list/blocs/blocs.dart';
import 'package:todo_list/services/todo_repository.dart';

final GetIt sl = GetIt.instance;

void initializeServiceLocator() {
  sl.registerSingleton<TodoRepository>(TodoHiveRepository());
  sl.registerSingleton<TodosBloc>(TodosBloc(sl<TodoRepository>()));
}
