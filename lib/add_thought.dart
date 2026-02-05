import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'gemini.dart';
import 'package:write_it_down/models/firestore.dart';

class AddThought extends StatefulWidget {
  const AddThought({super.key});

  @override
  State<AddThought> createState() => _AddThoughtState();
}

class _AddThoughtState extends State<AddThought> {
  final _pageController = PageController();
  String groupName = "General";
  String thoughtContent = "";

  void updateGroup(String newGroupName) {
    setState(() {
      groupName = newGroupName;
    });
  }

  void updateThought(String newThoughtContent) {
    setState(() {
      thoughtContent = newThoughtContent;
    });
  }
  @override
  Widget build(BuildContext context) {
    final firestore = context.read<FirestoreService>();

    return DraggableScrollableSheet(
    initialChildSize: .9,
    maxChildSize: .9,
    builder: (context, scrollController) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            TypeThought(pageController: _pageController, updateGroup: updateGroup, firestore: firestore, updateThought: updateThought,),
            ThoughtGroup(pageController: _pageController, groupName: groupName, firestore: firestore, thoughtContent: thoughtContent,),
            GroupsSelection(pageController: _pageController, updateGroup: updateGroup, firestore: firestore,),
          ],
        ),
      );
    }
  );
  }
}

//----------------------------------

class TypeThought extends StatefulWidget {
  const TypeThought({super.key, required this.pageController, required this.updateGroup, required this.firestore, required this.updateThought});

  final PageController pageController;
  final Function(String) updateGroup;
  final FirestoreService firestore;
  final Function(String) updateThought;

  @override
  State<TypeThought> createState() => _TypeThoughtState();
}

class _TypeThoughtState extends State<TypeThought> {
  var currentText = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: TextField(
                controller: currentText,
                autofocus: true,
                expands: true,
                maxLines: null,
                cursorColor: Theme.of(context).colorScheme.tertiary,
                showCursor: true,
                decoration: InputDecoration(
                  hintText: "Type your thought",
                  hintStyle: TextStyle(letterSpacing: .5)
                ),
              ),
            ),
            FloatingActionButton.extended(
              onPressed: () async {
                List<String> groups = await widget.firestore.currentGroups();
                String groupName = await Gemini.group(groups, currentText.text);
                widget.updateGroup(groupName);
                widget.updateThought(currentText.text);
                widget.pageController.nextPage(duration: Duration(milliseconds: 400), curve: Curves.ease);
              },
              label: Row(
                children: [
                  Icon(Icons.add_box_rounded),
                  Text("Throw thought"),
                  ],
                ),
              backgroundColor: Theme.of(context).colorScheme.tertiary,
            )
          ],
        ),
      );
  }
}

//----------------------------------

class ThoughtGroup extends StatelessWidget {
  const ThoughtGroup({super.key, required this.pageController, required this.groupName, required this.firestore, required this.thoughtContent});
  
  final PageController pageController;
  final String groupName;
  final FirestoreService firestore;
  final String thoughtContent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Text("Sorting your thought...", style: TextStyle(fontSize: 30, color: Theme.of(context).colorScheme.tertiary),),
                SizedBox(height: 70,),
                GestureDetector(
                  onTap: () => pageController.nextPage(duration: Duration(milliseconds: 400), curve: Curves.ease),
                  child: Container(
                    width: 200,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    child: Center(child: Text(groupName, style: TextStyle(fontSize: 30,))),
                  ),
                ),
              ],
            )
          ),
          FloatingActionButton.extended(
                onPressed: () {
                  firestore.newThought(groupName, thoughtContent, Timestamp.now());
                  Navigator.of(context).pop();
                },
                label: Row(
                  children: [
                    Icon(Icons.add_box_rounded),
                    Text("Confirm"),
                    ],
                  ),
                backgroundColor: Theme.of(context).colorScheme.tertiary,
            )
        ],
      ),
    );
  }
}

//----------------------------------

class GroupsSelection extends StatefulWidget {
  const GroupsSelection({super.key, required this.pageController, required this.updateGroup, required this.firestore});
  
  final PageController pageController;
  final Function(String) updateGroup;
  final FirestoreService firestore;

  @override
  State<GroupsSelection> createState() => _GroupsSelectionState();
}

class _GroupsSelectionState extends State<GroupsSelection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Select a group"),
        Expanded(
          child: StreamBuilder(
            stream: widget.firestore.groupsRef.snapshots(), 
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final groups = snapshot.data!.docs;

              return ListView.builder(
              itemCount: groups.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    widget.updateGroup(groups[index]['name']);
                    widget.pageController.jumpToPage(1);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    child: Text(groups[index]['name']),
                  ),
                );
              }
            );
            })
        ),
      ],
    );
  }
}