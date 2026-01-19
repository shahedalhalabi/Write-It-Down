import 'package:cloud_firestore/cloud_firestore.dart';

class Thought {
  String content;
  String? description;
  bool isCompleted = false;

  Thought({required this.content, this.description});

  Map<String, dynamic> toFireStore() {
    return {
      'content' : content, 
      if(description != null) 'description' : description, 
      'isCompleted' : isCompleted,
    };
  }

  factory Thought.fromFireStore(DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options) {
    final data = snapshot.data();
    return Thought(content: data?['content']);
  }
}