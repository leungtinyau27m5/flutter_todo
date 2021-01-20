import 'package:flutter/material.dart';
// import 'package:flutter_application_1/TodoItems.dart';
import 'dart:math';
import './Todos.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'To-Do List',
        // home: ToDoList()
        home: DefaultTabController(
          length: 3,
          child: ToDoList(),
        ));
  }
}

class ToDoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<ToDoList> with TickerProviderStateMixin {
  final TextEditingController textField = TextEditingController();
  final List<Todos> todoItems = <Todos>[];
  final List<Todos> doneItems = <Todos>[];
  final List<Todos> cancelItems = <Todos>[];
  int listIdex = 0;
  @override
  void initState() {
    super.initState();
  }

  void addItemInTodoList(TextEditingController textEditingController) {
    setState(() {
      todoItems.add(new Todos(
          id: generateTodoItemKey(),
          title: textEditingController.text,
          createDate: new DateTime.now(),
          done: false,
          cancel: false));
    });
    textEditingController.clear();
  }

  String generateTodoItemKey() {
    final date = new DateTime.now();
    return "${date.year.toString()}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}${listIdex++}${new Random()}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('To-Do List'),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.format_list_bulleted),
              ),
              Tab(icon: Icon(Icons.check)),
              Tab(icon: Icon(Icons.close_rounded))
            ],
          )),
      body: TabBarView(
        children: [
          buildDimissibleTodoItems(todoItems),
          // new TodoItems(todoItems),
          buildDimissibleDoneItems(doneItems),
          ListView(
            padding: EdgeInsets.only(top: 20.0),
            children: getTodoItem(TodoListType.cancel),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => displayDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget buildDimissibleTodoItems(List itemList) {
    return itemList.length > 0
        ? ListView.builder(
            itemCount: todoItems.length,
            itemBuilder: (_, index) {
              return Dismissible(
                  key: Key(todoItems[index].id),
                  onDismissed: (direction) {
                    setState(() {
                      todoItems
                          .removeWhere((ele) => ele.id == todoItems[index].id);
                      if (direction == DismissDirection.startToEnd) {
                        doneItems.add(itemList[index]);
                      } else if (direction == DismissDirection.endToStart) {
                        cancelItems.add(itemList[index]);
                      }
                    });
                  },
                  child: tempBuildTodoItem(todoItems[index]));
            },
          )
        : ListTile(
            title: Center(
                child: Text(
              'There is no todo Items',
              style: TextStyle(color: Colors.black38),
            )),
          );
  }

  Widget buildDimissibleDoneItems(List itemList) {
    return itemList.length > 0
        ? ListView.builder(
            itemCount: itemList.length,
            itemBuilder: (_, index) {
              return Dismissible(
                  key: Key(itemList[index].id),
                  onDismissed: (direction) {
                    setState(() {
                      itemList.removeWhere(
                          (element) => element.id == itemList[index].id);
                    });
                  },
                  child: tempBuildTodoItem(itemList[index]));
            },
          )
        : ListTile(
            title: Center(
            child: Text(
              'There is no finished Items',
              style: TextStyle(color: Colors.black38),
            ),
          ));
  }

  List<Widget> getTodoItem(TodoListType listType) {
    final List<Widget> widgets = <Widget>[];
    final List<Widget> showWhenEmpty = <Widget>[];
    switch (listType) {
      case TodoListType.doing:
        todoItems.forEach((element) => widgets.add(buildTodoItem(element)));
        break;
      case TodoListType.done:
        doneItems.forEach((element) => widgets.add(buildDoneItem(element)));
        break;
      case TodoListType.cancel:
        cancelItems.forEach((element) => widgets.add(buildTodoItem(element)));
        break;
      default:
        todoItems.forEach((element) => widgets.add(buildTodoItem(element)));
    }
    showWhenEmpty.add(ListTile(
      title: Center(
          child: Text(
        'There is no todo Items',
        style: TextStyle(color: Colors.black38),
      )),
    ));
    // showWhenEmpty.add(Center(child: Text('There is no todo Items')));
    return widgets.length > 0 ? widgets : showWhenEmpty;
  }

  //Create TodoItems in List
  Widget buildTodoItem(Todos todoItem) {
    return ListTile(
      title: Text(todoItem.title),
      trailing: Wrap(
        children: [
          RaisedButton(
            onPressed: () {
              setState(() {
                todoItems.removeWhere((element) => element.id == todoItem.id);
                doneItems.add(todoItem);
              });
            },
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
  }

  Widget buildDoneItem(Todos todoItem) {
    return ListTile(
      title: Text(todoItem.title),
      trailing: Wrap(
        children: [
          RaisedButton(
            onPressed: () {
              print('pressed');
              doneItems.removeWhere((element) => element.id == todoItem.id);
              todoItems.add(todoItem);
            },
            child: Icon(Icons.undo),
            // minWidth: 120,
            color: Colors.black54,
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget tempBuildTodoItem(Todos todoItem) {
    return ListTile(
      title: Text(todoItem.title),
      trailing: Wrap(
        children: [
          RaisedButton(
            onPressed: () {
              // print(todoItem.id);
              setState(() {
                todoItems.removeWhere((element) => element.id == todoItem.id);

                doneItems.add(todoItem);
              });
            },
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
  }

  //Dislog for adding Items
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
