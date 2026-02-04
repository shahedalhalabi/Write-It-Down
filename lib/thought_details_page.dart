import 'package:flutter/material.dart';

class ThoughtDetailsPage extends StatefulWidget {
  const ThoughtDetailsPage({super.key});
  //pass thought
  @override
  State<ThoughtDetailsPage> createState() => _ThoughtDetailsPageState();
}

class _ThoughtDetailsPageState extends State<ThoughtDetailsPage> {
  var currentText = TextEditingController(text: "My thought");

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: .9,
      maxChildSize: .9,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: Theme.of(context).colorScheme.primary,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Center(child: Text("Wed 4 Feb 10:25PM")),
                Expanded(
                  child: TextField(
                    controller: currentText,
                    autofocus: true,
                    expands: true,
                    maxLines: null,
                    cursorColor: Theme.of(context).colorScheme.tertiary,
                    showCursor: true,
                  ),
                ),
                FloatingActionButton.extended(
                  onPressed: () {
                    //update thought
                    Navigator.pop(context);
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
          ),
        );
      }
    );
  }
}