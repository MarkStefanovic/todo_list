import 'package:hive/hive.dart';

part "priority.g.dart";

@HiveType()
enum Priority {
  @HiveField(0)
  low,

  @HiveField(1)
  high,
}