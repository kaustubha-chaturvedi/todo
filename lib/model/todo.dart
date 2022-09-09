class ToDo {
  String? id;
  String? todo;
  bool? isDone;

  ToDo({
    required this.id,
    required this.todo,
    this.isDone = false,
  });

  static List<ToDo> todolist() {
    return [
      ToDo(
        id: '1',
        todo: 'Buy Groceries',
        isDone: false,
      ),
      ToDo(
        id: '2',
        todo: 'Do Laundry',
        isDone: true,
      ),
      ToDo(
        id: '3',
        todo: 'Pay Bills',
      ),
      ToDo(
        id: '4',
        todo: 'Book Tickets',
      ),
    ];
  }
}
