import 'package:cloud_firestore/cloud_firestore.dart';

class Thought {
  String content;
  Timestamp date;

  Thought({required this.content, required this.date});

  Map<String, dynamic> toFireStore() {
    return {
      'content' : content, 
      'date' : date, 
    };
  }

  factory Thought.fromFireStore(DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options) {
    final data = snapshot.data();
    return Thought(content: data?['content'], date: data?['date']);
  }
}
