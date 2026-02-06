import 'package:flutter/material.dart';
import 'thought_details_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:write_it_down/models/firestore.dart';
import 'package:provider/provider.dart';

class BrainIndexPage extends StatefulWidget {
  const BrainIndexPage({super.key});

  @override
  State<BrainIndexPage> createState() => _BrainIndexPageState();
}

class _BrainIndexPageState extends State<BrainIndexPage> {
  @override
  Widget build(BuildContext context) {
    final firestore = context.read<FirestoreService>();

    return StreamBuilder(
      stream: firestore.groupsRef.snapshots(), 
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final groups = snapshot.data!.docs;

        return ListView.builder(
          itemCount: groups.length,
          itemBuilder: (context, index) {
            return ExpansionTile(
                  leading: Icon(Icons.backpack),
                  title: Text(groups[index]['name']),
                  children: [
                    StreamBuilder(
                      stream: firestore.thoughtsRef(groups[index].reference).snapshots(), 
                      builder: (context, snapshot) {
                        if(!snapshot.hasData) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        final thoughts = snapshot.data!.docs;

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: thoughts.length,
                          itemBuilder: (context, tindex) {
                            return ListTile(
                              title: Text(thoughts[tindex]['content']),
                              onTap: () => showModalBottomSheet(
                                context: context, 
                                builder: (context) => ThoughtDetailsPage(thought: thoughts[tindex].data(), thoughtRef: thoughts[tindex].reference,),
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                              ),
                            );
                          },
                        );
                      })
                    ]
            );
          });
  
      });
  }
}