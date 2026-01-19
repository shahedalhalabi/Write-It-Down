import 'package:cloud_firestore/cloud_firestore.dart';

class Group {
  String name;

  Group({required this.name});

  Map<String, dynamic> toFireStore() {
    return { "name" : name, };
  }

  factory Group.fromFireStore(DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options) {
    final data = snapshot.data();
    return Group(name: data?["name"]);
  }
}