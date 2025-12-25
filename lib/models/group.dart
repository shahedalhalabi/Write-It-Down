import 'package:isar/isar.dart';
import 'thought.dart';

part 'group.g.dart';

@collection
class Group {
  Id id = Isar.autoIncrement;
  String name;
  
  final thoughts = IsarLinks<Thought>();

  
  Group({required this.name});

  void addThought(Thought thought) {
    thoughts.add(thought);
  }
}