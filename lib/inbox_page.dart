import 'package:flutter/material.dart';
import 'add_thought.dart';

class InboxPage extends StatefulWidget {
  const InboxPage({super.key});

  @override
  State<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
              //color: Theme.of(context).colorScheme.tertiary,
              ),
              child: Text(
                "Lately, You've been into trying new foods and restaurants! Let's keep trying!",
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: "CupertinoSystemDisplay",
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.tertiary
                  ),  
                ),
            ),
            GestureDetector(
              onTap: () => showModalBottomSheet(
                context: context, 
                builder: (context) => AddThought(),
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                ),
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).colorScheme.primary,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.tertiary,
                      spreadRadius: 5,
                      blurRadius: 7,
                    )
                  ]
                  ),
                child: Text("Capture your thoughts! \nThat thing you'll forget in 5 minutes…"),
              ),
            )
          ],
        ),
      );
  }
}