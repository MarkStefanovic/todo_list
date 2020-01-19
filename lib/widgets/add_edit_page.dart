import 'package:dartz/dartz.dart' show Function2;
import 'package:flutter/material.dart';
import 'package:todo_list/localization.dart';
import 'package:todo_list/models/models.dart';
import 'package:todo_list/widgets/keys.dart';

typedef OnSaveCallback = Function(String title, String note);

class AddEditPageArguments {
  final Function2<String, String, void> onSave;
  final Todo todo;
  final bool isEditing;

  const AddEditPageArguments({
    @required this.onSave,
    @required this.todo,
    @required this.isEditing,
  })  : assert(todo != null),
        assert(onSave != null),
        assert(isEditing != null);
}

class AddEditPage extends StatefulWidget {
  final bool isEditing;
  final OnSaveCallback onSave;
  final Todo todo;

  AddEditPage({
    Key key,
    @required this.onSave,
    @required this.todo,
    @required this.isEditing,
  }) : super(key: key ?? WidgetKeys.addTodoPage);

  @override
  _AddEditPageState createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
  final _formKey = GlobalKey<FormState>();

  String _title;
  String _note;

  bool get isEditing => widget.isEditing;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? localizations.editTodo : localizations.addTodo),
      ),
      body: Form(
        key: _formKey,
        autovalidate: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              initialValue: isEditing ? widget.todo.description : "",
              key: WidgetKeys.titleField,
              autofocus: !isEditing,
              style: textTheme.headline,
              decoration: InputDecoration(
                hintText: localizations.newTodoHint,
              ),
              onSaved: (value) => setState(() => _title = value),
//              onSaved: (value) => _title = value,
              validator: (val) {
                return val.trim().isEmpty ? localizations.emptyTodoError : null;
              },
            ),
            Expanded(
              child: TextFormField(
                initialValue: isEditing ? widget.todo.note : "",
                key: WidgetKeys.noteField,
                maxLines: 10,
                style: textTheme.subhead,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter a title.";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: localizations.notesHint,
                ),
                onSaved: (value) => setState(() => _note = value),
//                onSaved: (value) => _note = value,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                onPressed: () {
                  final form = _formKey.currentState;
                  debugPrint(form.toString());
                  if (form.validate()) {
                    form.save();
                    widget.onSave(_title, _note);
                    Navigator.pop(context);
                  }
                },
                child: Text(localizations.addEditSaveButtonText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
