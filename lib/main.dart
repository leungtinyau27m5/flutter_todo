import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'To-Do List', home: ToDoList());
  }
}

class ToDoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<ToDoList> with TickerProviderStateMixin {
  final TextEditingController textField = TextEditingController();
  TabController _tabController;
  final List<String> todoItems = <String>[];

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('To-Do List'),
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(
                // text: 'To Do',
                icon: Icon(Icons.format_list_bulleted),
              ), 
              Tab(icon: Icon(Icons.check)), 
              Tab(icon: Icon(Icons.close_rounded))
            ],
          )),
      body: ListView(children: getTodoItem()),
      floatingActionButton: FloatingActionButton(
        onPressed: () => displayDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void addItemInTodoList(TextEditingController textEditingController) {
    print("addItemInTodoList: ${textEditingController.text}");
    setState(() {
      todoItems.add(textEditingController.text);
    });
    textEditingController.clear();
  }

  List<Widget> getTodoItem() {
    final List<Widget> widgets = <Widget>[];
    print(todoItems);
    todoItems.forEach((element) => widgets.add(buildTodoItem(element)));
    print(widgets);
    return widgets;
  }

  Widget buildTodoItem(String title) {
    return ListTile(
      title: Text(title),
      trailing: Wrap(
        children: [
          RaisedButton(
            onPressed: () {},
            child: Icon(Icons.check),
            // minWidth: 120,
            color: Colors.green,
            textColor: Colors.white,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: RaisedButton(
              onPressed: () {},
              child: Icon(Icons.close),
              color: Colors.red,
              textColor: Colors.white,
            ),
          )
        ],
      ),
    );
    // return Row(
    //   children: <Widget>[Text(title)],
    // );
  }

  Future<AlertDialog> displayDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text('Add a task to your list'),
              content: TextField(
                  controller: textField,
                  decoration:
                      const InputDecoration(hintText: 'Enter task here')),
              actions: <Widget>[
                FlatButton(
                  child: const Text('Add'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    addItemInTodoList(textField);
                  },
                ),
                FlatButton(
                  child: Text('CANCEL'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ]);
        });
  }
}
