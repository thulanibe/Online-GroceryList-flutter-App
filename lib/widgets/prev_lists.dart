import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Lists', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      body: const SavedListsPage(),
    );
  }
}

class SavedListsPage extends StatefulWidget {
  const SavedListsPage({super.key});

  @override
  _SavedListsPageState createState() => _SavedListsPageState();
}

class _SavedListsPageState extends State<SavedListsPage> {
  final List<String> savedLists = ['List A', 'List B', 'List C'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Lists', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: savedLists.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(
              Icons.list,
              color: Colors.green,
            ),
            title: Text(savedLists[index],
                style: const TextStyle(color: Colors.black)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PreviousListsPage(savedLists[index]),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.green,
            ),
            onPressed: () {
              // Implement the functionality to add a new list
              // For example, show a dialog to enter the list name.
            },
          ),
          const Spacer(), // Adds space between the icons
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () {
              // Implement the functionality to delete the list
              // For example, show a dialog for deleting the list.
            },
          ),
        ],
      ),
    );
  }
}

class PreviousListsPage extends StatelessWidget {
  final String listName;

  const PreviousListsPage(this.listName, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Details: $listName',
            style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Text('Details for $listName',
            style: const TextStyle(color: Colors.black)),
      ),
      bottomNavigationBar: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.edit,
              color: Colors.green,
            ),
            onPressed: () {
              // Implement the functionality to edit the list
              // For example, allow the user to update list details.
            },
          ),
          const Spacer(), // Adds space between the icons
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () {
              // Implement the functionality to delete the list
              // For example, show a dialog for deleting the list.
            },
          ),
        ],
      ),
    );
  }
}
