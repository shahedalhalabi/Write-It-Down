import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
//import 'gemini.dart';
//import 'package:write_it_down/models/firestore.dart';
import 'inbox_page.dart';
import 'brain_index_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title, 
          style: TextStyle(
            fontFamily: "CupertinoSystemText", 
            fontWeight: FontWeight.bold, 
            fontSize: 30, 
            color: Theme.of(context).colorScheme.tertiary
            ),
          ),
        centerTitle: false,
      ),
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        selectedIndex: currPageIndex,
        onDestinationSelected: (int newPageIndex) {
          setState(() {
            currPageIndex = newPageIndex;
          });
        },
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: "Inbox",),
          NavigationDestination(icon: Icon(Icons.folder), label: "Brain Index"),
        ]),
      body: [InboxPage(), BrainIndexPage()][currPageIndex],
    );
  }
}
