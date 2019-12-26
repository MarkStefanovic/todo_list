import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:todo_list/models/priority.dart';

part "todo.g.dart";

@HiveType()
class Todo extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  String description;

  @HiveField(2)
  String date;

  @HiveField(3)
  Priority priority;

  @HiveField(4)
  bool complete;

  @HiveField(5)
  String note;

  //<editor-fold desc="Data Methods" defaultstate="collapsed">

  Todo({
    @required this.id,
    @required this.description,
    @required this.date,
    @required this.priority,
    @required this.complete,
    @required this.note,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Todo &&
          runtimeType == other.runtimeType &&
          description == other.description &&
          date == other.date &&
          priority == other.priority &&
          complete == other.complete &&
          note == other.note);

  @override
  int get hashCode =>
      id.hashCode ^
      description.hashCode ^
      date.hashCode ^
      priority.hashCode ^
      complete.hashCode ^
      note.hashCode;

  @override
  String toString() {
    return 'Todo {' +
        ' id: $id,' +
        ' description: $description,' +
        ' date: $date,' +
        ' priority: $priority,' +
        ' complete: $complete,' +
        ' note: $note, ' +
        '}';
  }

  Todo copyWith({
    int id,
    String description,
    String date,
    Priority priority,
    bool complete,
    String note,
  }) => Todo(
    id: id ?? this.id,
    description: description ?? this.description,
    date: date ?? this.date,
    priority: priority ?? this.priority,
    complete: complete ?? this.complete,
    note: note ?? this.note,
  );

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'description': this.description,
      'date': this.date,
      'priority': this.priority,
      'complete': this.complete,
      'note': this.note,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return new Todo(
      id: map['id'] as int,
      description: map['description'] as String,
      date: map['date'] as String,
      priority: map['priority'] as Priority,
      complete: map['complete'] as bool,
      note: map['note'] as String,
    );
  }
//</editor-fold>
}

final dummyTodo = Todo(
  id: -1,
  description: "",
  date: "1900-01-01",
  priority: Priority.high,
  complete: false,
  note: "",
);
