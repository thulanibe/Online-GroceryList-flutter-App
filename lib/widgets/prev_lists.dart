import 'package:flutter/material.dart';

class SavedListsPage extends StatefulWidget {
  SavedListsPage({Key? key}) : super(key: key);

  @override
  _SavedListsPageState createState() => _SavedListsPageState();
}

class _SavedListsPageState extends State<SavedListsPage> {
  final List<String> savedLists = ['List A', 'List B', 'List C'];

  void _deleteList(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete List'),
          content:
              Text('Are you sure you want to delete ${savedLists[index]}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  savedLists.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _renameList(int index) {
    TextEditingController _listNameController = TextEditingController();
    _listNameController.text = savedLists[index];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Rename List'),
          content: TextField(
            controller: _listNameController,
            decoration: InputDecoration(labelText: 'New List Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                String editedListName = _listNameController.text.trim();
                if (editedListName.isNotEmpty) {
                  setState(() {
                    savedLists[index] = editedListName;
                  });
                }
                Navigator.of(context).pop();
              },
              child: Text('Rename'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Lists', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Add functionality for adding a new list
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: savedLists.length,
        itemBuilder: (context, index) {
          return ListTile(
            tileColor: Colors.grey[200], // Background color
            leading: Icon(
              Icons.list,
              color: Colors.green,
            ),
            title: Text(savedLists[index]),
            trailing: PopupMenuButton(
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    value: 'delete',
                    child: Text('Delete'),
                  ),
                  PopupMenuItem(
                    value: 'rename',
                    child: Text('Rename'),
                  ),
                ];
              },
              onSelected: (String value) {
                if (value == 'delete') {
                  _deleteList(index);
                } else if (value == 'rename') {
                  _renameList(index);
                }
              },
            ),
          );
        },
      ),
    );
  }
}

class PreviousListsPage extends StatefulWidget {
  final String listName;

  const PreviousListsPage(this.listName, {Key? key}) : super(key: key);

  @override
  _PreviousListsPageState createState() => _PreviousListsPageState();
}

class _PreviousListsPageState extends State<PreviousListsPage> {
  late TextEditingController _listNameController;
  late String _editedListName;

  @override
  void initState() {
    super.initState();
    _listNameController = TextEditingController(text: widget.listName);
    _editedListName = widget.listName;
  }

  void _editListName() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit List Name'),
          content: TextField(
            controller: _listNameController,
            decoration: InputDecoration(labelText: 'List Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                String editedListName = _listNameController.text.trim();
                if (editedListName.isNotEmpty) {
                  setState(() {
                    _editedListName = editedListName;
                  });
                }
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prev Lists: $_editedListName',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Text('Details for $_editedListName',
            style: TextStyle(color: Colors.black)),
      ),
      bottomNavigationBar: ListTile(
        leading: IconButton(
          icon: Icon(
            Icons.edit,
            color: Colors.green,
          ),
          onPressed: () {
            _editListName();
          },
        ),
        title: Spacer(),
        trailing: IconButton(
          icon: Icon(
            Icons.delete,
            color: Colors.red,
          ),
          onPressed: () {
            // Implement the functionality to delete the list
            // For example, show a dialog for deleting the list.
          },
        ),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: SavedListsPage(),
    ),
  );
}
