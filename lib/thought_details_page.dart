import 'package:flutter/material.dart';
import 'package:write_it_down/models/thought.dart';

class ThoughtDetailsPage extends StatefulWidget {
  const ThoughtDetailsPage({super.key, required this.thought});

  final Thought thought;

  @override
  State<ThoughtDetailsPage> createState() => _ThoughtDetailsPageState();
}

class _ThoughtDetailsPageState extends State<ThoughtDetailsPage> {
  late TextEditingController currentText;

  @override
  void initState() {
    super.initState();
    currentText = TextEditingController(text: widget.thought.content);
  }

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
                Center(child: Text(widget.thought.date.toDate().toString())),
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
                      Icon(Icons.update),
                      Text("Update thought"),
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