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
        final AddEditPageArguments args = settings.arguments;
        debugPrint("addEditPage request args = $args");
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
            title: Text('Error'),
          ),
          body: Center(
            child: Text('ERROR'),
          ),
        );
      },
    );
  }
}
