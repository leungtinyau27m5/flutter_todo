enum TodoListType {
  doing,
  done,
  cancel
}

class Todos {
  final String id;
  final String title;
  final DateTime createDate;
  final bool done;
  final bool cancel;
  
  Todos({
    this.id,
    this.title, 
    this.createDate, 
    this.done, 
    this.cancel
  });
}
