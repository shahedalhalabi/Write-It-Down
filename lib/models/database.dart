import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'group.dart';
import 'thought.dart';

class Database extends ChangeNotifier{
  late Isar isar;

  //Initialize
  Future<void> init() async {
      final dir = await getApplicationDocumentsDirectory();
      // Only open if not already open
      if (Isar.instanceNames.isEmpty) {
        isar = await Isar.open(
          [ThoughtSchema, GroupSchema], // Include all schemas
          directory: dir.path,
        );
      }
  }

  //Create
  Future<void> newGroup(String groupName) async {
    Group group = Group(name: groupName);

    await isar.writeTxn(() async {
      await isar.groups.put(group);
    });
    notifyListeners();
  }

  Future<void> newThought(String groupName, String thoughtContent, String? thoghtDescription) async {
    
    await isar.writeTxn(() async {
    Group? group = await isar.groups.filter().nameEqualTo(groupName).findFirst();
    if (group == null) {
      group = Group(name: groupName);
      await isar.groups.put(group);
    }
    
    final thought = Thought(content: thoughtContent, description: thoghtDescription);
    await isar.thoughts.put(thought);

    group.thoughts.add(thought);
    await group.thoughts.save();
  });

    notifyListeners();
  }

  Future<void> toggleThought(Thought thought) async{
    thought.isCompleted = !thought.isCompleted;
    await isar.writeTxn(() async {
      await isar.thoughts.put(thought);
    });
    notifyListeners();
  }

  Future<List<String>> currentGroups() async{
    return await isar.groups.where().nameProperty().findAll();
  }
  
}
