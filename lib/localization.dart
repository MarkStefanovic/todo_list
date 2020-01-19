import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'errors.dart';

class AppLocalizations {
  String get addEditSaveButtonText => translate("add_edit_save_button_text");

  String get addTodo => translate("add_todo");

  String get addTodoButtonTooltip => translate("add_todo_button_tooltip");

  String get deleteTodoButtonTooltip => translate("delete_todo_button_tooltip");

  String get editTodo => translate("edit_todo");

  String get emptyTodoError => translate("empty_todo_error");

  String get newTodoHint => translate("new_todo_hint");

  String get notesHint => translate("notes_hint");

  String get saveChangesTooltip => translate("save_changes_tooltip");

  String get title => translate("title");

  String get todoDetailsAppBarTitle => translate("todoD_details_app_bar_title");

  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      "add_edit_save_button_text": "Save",
      "add_todo_button_tooltip": "Add a new ToDo",
      "add_todo": "Add",
      "delete_todo_button_tooltip": "Delete",
      "edit_todo": "Edit",
      "edit_todo_error": "The title field cannot be blank",
      "new_todo_hint": "New Todo",
      "notes_hint": "Additional information about the ToDo",
      "save_changes_tooltip": "Save Changes",
      "title": "ToDos",
      "todoD_details_app_bar_title": "ToDos",
    },
  };

  String translate(String key) {
    final localizations = _localizedValues[locale.languageCode];
    if (localizations == null) {
      final msg = "There are no localizations messages for the "
          "${locale.languageCode} language.";
      debugPrint(msg);
      throw UnsupportedLocale(msg);
    }

    final msg = localizations[key];
    if (msg == null) {
      final errorMessage = "Missing a localization message for the $key key.";
      throw MissingLocalizationMessageError(errorMessage);
    } else {
      return localizations[key];
    }
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'es'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
