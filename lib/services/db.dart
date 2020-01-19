import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:todo_list/models/models.dart';

const currentVersion = 20191224;

Future<void> startHive() async {
  final dir = await path.getApplicationDocumentsDirectory();
  final filepath = join(dir.path, "db.hive");
  Hive.init(filepath);
  Hive.registerAdapter(PriorityAdapter(), 0);
  Hive.registerAdapter(TodoAdapter(), 1);
  await Hive.openBox<Todo>("todos");
  debugPrint("Initialized Hive database at $filepath");
}