class ToDo{
  String? id;
  String? todotext;
  bool isDone;

  ToDo({
    required this.id,
    this.isDone = false,
    required this.todotext,
  });

  static List<ToDo> todoList(){
    return[
     
    ];
  }
}