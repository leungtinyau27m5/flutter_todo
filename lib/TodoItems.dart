import 'package:flutter/material.dart';
import './Todos.dart';

class TodoItems extends StatefulWidget {
  TodoItems({Key key, @required this.itemList}) : super(key: key);
  final List itemList;

  @override
  _TodoItemState createState() => _TodoItemState(itemList);
}

class _TodoItemState extends State<TodoItems> {
  _TodoItemState(this.itemList);

  List itemList;

  @override
  Widget build(BuildContext context) {
    return itemList.length > 0
        ? ListView.builder(
            itemCount: itemList.length,
            itemBuilder: (_, index) {
              return Dismissible(
                  key: Key(itemList[index].id),
                  onDismissed: (direction) {
                    setState(() {
                      itemList
                          .removeWhere((ele) => ele.id == itemList[index].id);
                      if (direction == DismissDirection.startToEnd) {
                        itemList.add(itemList[index]);
                      } else if (direction == DismissDirection.endToStart) {
                        itemList.add(itemList[index]);
                      }
                    });
                  },
                  child: tempBuildTodoItem(itemList[index]));
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

  Widget tempBuildTodoItem(Todos todoItem) {
    return ListTile(
      title: Text(todoItem.title),
      trailing: Wrap(
        children: [
          RaisedButton(
            onPressed: () {
              // print(todoItem.id);
              setState(() {
                itemList.removeWhere((element) => element.id == todoItem.id);

                itemList.add(todoItem);
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
}
