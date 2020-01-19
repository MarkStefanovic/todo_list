import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:todo_list/blocs/blocs.dart';
import 'package:todo_list/service_locator.dart';
import 'package:todo_list/services/db.dart';
import 'package:todo_list/services/todo_repository.dart';
import 'package:todo_list/widgets/widgets.dart';

import 'localization.dart';
import 'routes.dart';

Future<void> main() async {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  WidgetsFlutterBinding.ensureInitialized();
  await startHive();
  initializeServiceLocator();
  runApp(
    BlocProvider(
      create: (context) {
        final todoRepository = sl<TodoRepository>();
        final TodosBloc todosBloc = TodosBloc(todoRepository);
        todosBloc.add(TodoEvent.loadTodos());
        return todosBloc;
      },
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ToDos",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      supportedLocales: const [
        Locale("en", "US"),
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) =>
          supportedLocales.firstWhere(
        (supportedLocale) =>
            supportedLocale.languageCode == locale.languageCode &&
            supportedLocale.countryCode == locale.countryCode,
        orElse: () => supportedLocales.first,
      ),
      home: TodoList(),
      initialRoute: Routes.home,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }

  @override
  void dispose() {
    // if you want to force hive to compact on close, uncomment the following line:
    // Hive.box("todos").compact();
    Hive.close();
    super.dispose();
  }
}
