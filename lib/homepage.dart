import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';
import 'package:write_it_down/models/database.dart';
import 'package:write_it_down/models/group.dart';
import 'package:write_it_down/models/thought.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var currentText = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    final db = Provider.of<Database>(context, listen: false);

    void addThought() {
      db.newThought("My Group", currentText.text, "my description");
    }

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
                    hintText: "Add your new ToDo!",
                    suffixIcon: IconButton(onPressed: (){currentText.clear();}, icon: Icon(Icons.clear)),
                  ),
                  controller: currentText,
                  
                ),
              Expanded(
                child: StreamBuilder(
                  stream: db.isar.groups.where().watch(fireImmediately: true), 
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final groups = snapshot.data!;

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
                              Text(groups[index].name),
                              Expanded(
                                child: StreamBuilder(
                                  stream: db.isar.thoughts.where().watch(fireImmediately: true), 
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return const Center(child: CircularProgressIndicator());
                                    }
                                    final thoughts = snapshot.data!;

                                    return ListView.builder(
                                      itemCount: thoughts.length,
                                      itemBuilder: (context, index) {
                                        return CheckboxListTile(
                                            title: Text(thoughts[index].content),
                                            value: thoughts[index].isCompleted,
                                            onChanged: (bool? value) async {
                                              await db.toggleThought(thoughts[index]);
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addThought();
          currentText.clear();
        },
        tooltip: 'Increment',
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add),
      ),
    );
  }
}


