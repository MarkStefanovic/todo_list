import 'package:flutter/material.dart';

import 'keys.dart';

class LoadingSpinner extends StatelessWidget {
  LoadingSpinner({Key key}) : super(key: key ?? WidgetKeys.loadingSpinner);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
