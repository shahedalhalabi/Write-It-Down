//import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'thought_details_page.dart';

class BrainIndexPage extends StatefulWidget {
  const BrainIndexPage({super.key});

  @override
  State<BrainIndexPage> createState() => _BrainIndexPageState();
}

class _BrainIndexPageState extends State<BrainIndexPage> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return ExpansionTile(
              leading: Icon(Icons.backpack),
              title: Text("Group $index"),
              /*onExpansionChanged: (bool expands) {
                setState(() {
                  
                });
              },*/
              children: [
                ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, tindex) {
                  return ListTile(
                    title: Text("Thought $tindex"),
                    onTap: () => showModalBottomSheet(
                      context: context, 
                      builder: (context) => ThoughtDetailsPage(),
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                    ),
                  );
                },
              ),
              ],
            );
      });
  }
}