import 'package:flutter/material.dart';

class AddThought extends StatefulWidget {
  const AddThought({super.key});

  @override
  State<AddThought> createState() => _AddThoughtState();
}

class _AddThoughtState extends State<AddThought> {
  final _pageController = PageController();
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
        child: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            TypeThought(pageController: _pageController,),
            ThoughtGroup(pageController: _pageController,),
            GroupsSelection(pageController: _pageController,),
          ],
        ),
      );
    }
  );
  }
}

//----------------------------------

class TypeThought extends StatefulWidget {
  const TypeThought({super.key, required this.pageController});

  final PageController pageController;

  @override
  State<TypeThought> createState() => _TypeThoughtState();
}

class _TypeThoughtState extends State<TypeThought> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: TextField(
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
              onPressed: () {
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
  const ThoughtGroup({super.key, required this.pageController});
  
  final PageController pageController;

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
                    child: Center(child: Text("Outfits", style: TextStyle(fontSize: 30,))),
                  ),
                ),
              ],
            )
          ),
          FloatingActionButton.extended(
                onPressed: () {
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
  const GroupsSelection({super.key, required this.pageController});
  
  final PageController pageController;

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
          child: ListView.builder(
            itemCount: 30,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => widget.pageController.jumpToPage(1),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  child: Text("Group # $index"),
                ),
              );
            }
          ),
        ),
      ],
    );
  }
}