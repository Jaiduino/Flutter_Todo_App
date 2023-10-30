class Todo {
  String? id;
  String? todoText;
  bool? isDone;

  Todo({this.id, this.todoText, this.isDone});
  static List<Todo> todoList() {
    return [
      Todo(id: '01', todoText: 'Morning Exrecise', isDone: false),
      Todo(id: '02', todoText: 'Morning Breakfast', isDone: true),
      Todo(id: '03', todoText: 'Go to Office', isDone: false),
      Todo(id: '04', todoText: 'Morning Exrecise', isDone: true)
    ];
  }
}
