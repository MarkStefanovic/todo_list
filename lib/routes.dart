import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'widgets/widgets.dart';

class Routes {
  static const home = "/";
  static const addEditPage = "/addEditPage";
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    debugPrint("route = ${settings.name}, args = ${settings.arguments}");

    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (_) => ListView());
      case Routes.addEditPage:
        final args = settings.arguments as AddEditPageArguments;
        return MaterialPageRoute(builder: (context) {
          return AddEditPage(
            isEditing: args.isEditing,
            onSave: args.onSave,
            todo: args.todo,
          );
        });
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Error'),
          ),
          body: const Center(
            child: Text('ERROR'),
          ),
        );
      },
    );
  }
}
