import 'package:isar/isar.dart';
import 'group.dart';

part 'thought.g.dart';

@collection
class Thought {
  Id id = Isar.autoIncrement;
  String content;
  String? description;
  bool isCompleted = false;

  @Backlink(to: "thoughts")
  final group = IsarLink<Group>();

  Thought({required this.content, this.description});
}