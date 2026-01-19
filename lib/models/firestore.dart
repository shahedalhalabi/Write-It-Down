import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'thought.dart';
import 'group.dart';

class FirestoreService extends ChangeNotifier{
  final db = FirebaseFirestore.instance;
  final groupsRef = FirebaseFirestore.instance
                                    .collection("groups").withConverter(
                                                            fromFirestore: Group.fromFireStore, 
                                                            toFirestore: (Group group, options) => group.toFireStore(),
                                                          );
  CollectionReference<Thought> thoughtsRef(DocumentReference<Group> groupDocRef) {
    return groupDocRef.collection("thoughts").withConverter(
                                                fromFirestore: Thought.fromFireStore, 
                                                toFirestore: (thought, options) => thought.toFireStore(),
                                              );
  }


  Future<DocumentReference<Group>> newGroup(String groupName) async {
    final groupSnapshot = await groupsRef.where("name", isEqualTo: groupName).get();
    if(groupSnapshot.docs.isEmpty) {
      return await groupsRef.add(Group(name: groupName));
    }
    return groupSnapshot.docs.first.reference;
  }

  Future<void> newThought(String groupName, String thoughtContent, String? thoghtDescription) async {
    
    final groupDocRef = await newGroup(groupName);

    final thought = Thought(content: thoughtContent, description: thoghtDescription);
    await thoughtsRef(groupDocRef).add(thought);
    
    notifyListeners();
  }

  //Future<void> toggleThought()
  
  Future<List<String>> currentGroups() async{
    final groupSnapshot = await groupsRef.get();
    List<String> groups = [ ];
    for(var group in groupSnapshot.docs) {
      groups.add(group.data().name);
    }
    return groups;
  }
}