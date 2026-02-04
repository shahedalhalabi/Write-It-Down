import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'gemini.dart';
import 'package:write_it_down/models/firestore.dart';

class Oldhomepage extends StatefulWidget {
  const Oldhomepage({super.key, required this.title});

  final String title;

  @override
  State<Oldhomepage> createState() => _OldhomepageState();
}

class _OldhomepageState extends State<Oldhomepage> {

  var currentText = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    final firestore = context.read<FirestoreService>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Add your thought!",
                    suffixIcon: IconButton(onPressed: (){currentText.clear();}, icon: Icon(Icons.clear)),
                  ),
                  controller: currentText,
                  
                ),
              Expanded(
                child: StreamBuilder(
                  stream: firestore.groupsRef.snapshots(), 
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final groups = snapshot.data!.docs;

                    return ListView.builder(
                      itemCount: groups.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 200,
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                          child: Column(
                            children: [
                              Text(groups[index]["name"]),
                              Expanded(
                                child: StreamBuilder(
                                  stream: firestore.thoughtsRef(groups[index].reference).snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return const Center(child: CircularProgressIndicator());
                                    }
                                    final thoughts = snapshot.data!.docs;

                                    return ListView.builder(
                                      itemCount: thoughts.length,
                                      itemBuilder: (context, index) {
                                        return CheckboxListTile(
                                            title: Text(thoughts[index]["content"]),
                                            value: thoughts[index]["isCompleted"],
                                            onChanged: (bool? value) async {
                                              await firestore.toggleThought(thoughts[index].reference, !thoughts[index]["isCompleted"]);
                                            },
                                          );
                                        },
                                    );
                                  })  
                              ),
                            ],
                          ),
                        );
                        },
                    );
                  })  
              ),
            ]
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async{
          List<String> groups = await firestore.currentGroups();
          final group = await Gemini.group(groups, currentText.text);
          firestore.newThought(group, currentText.text, "my description");
          currentText.clear();
        },
        backgroundColor: Theme.of(context).colorScheme.primary,  
        label: Row(
          children: [
            Icon(Icons.add_box_rounded),
            Text("Throw thought"),
          ],
        ),
      ),
    );
  }
}


