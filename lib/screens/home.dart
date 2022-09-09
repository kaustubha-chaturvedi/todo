import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../model/todo.dart';
import '../widgets/todo_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<ToDo> todoList = ToDo.todolist();
  List<ToDo> filteredTodos = [];
  final TextEditingController _addTodoController = TextEditingController();
  final TextEditingController _searchTodoController = TextEditingController();

  @override
  void initState() {
    filteredTodos = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBGColor,
      appBar: _appBar(),
      bottomNavigationBar: _bottomAppBar(context, _addTodoController),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _searchBox(_searchTodoController),
            Container(
              margin: const EdgeInsets.only(bottom: 10, top: 10),
              child: const Text(
                'All ToDos',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: filteredTodos.length,
                    itemBuilder: (context, index) {
                      return ToDoItem(
                        todo: filteredTodos[index],
                        onChange: _handleChange,
                        onDelete: _handleDelete,
                      );
                    }))
          ],
        ),
      ),
    );
  }

  void _handleChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone!;
    });
  }

  void _handleDelete(String id) {
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
  }

  void _handleAdd(String todo) {
    setState(() {
      todoList.add(ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todo: todo,
          isDone: false));
    });
    _addTodoController.clear();
  }

  void _handleSearch(String query) {
    List<ToDo> result = [];
    if (query.isEmpty) {
      result = todoList;
    } else {
      result = todoList
          .where(
              (todo) => todo.todo!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    setState(() {
      filteredTodos = result;
    });
  }

  BottomAppBar _bottomAppBar(
      BuildContext context, TextEditingController addTodoController) {
    return BottomAppBar(
      color: cBGColor,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: addTodoController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  border: InputBorder.none,
                  hintText: 'Add Task todo',
                  hintStyle: TextStyle(color: cGrey),
                ),
              ),
            ),
            IconButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(cRed),
                shape: MaterialStateProperty.all(const CircleBorder()),
              ),
              onPressed: () {
                _handleAdd(addTodoController.text);
              },
              icon: const Icon(
                Icons.add,
                color: cBlue,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _searchBox(TextEditingController searchTodoController) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: cWhite,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        onChanged: (value) => _handleSearch(value),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(10),
          prefixIcon: Icon(
            Icons.search,
            color: cBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 30,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: cGrey),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: cBGColor,
      elevation: 0,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Text('Todo',
            style: TextStyle(
                fontSize: 24, color: cBlack, fontWeight: FontWeight.bold)),
        SizedBox(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: Image.asset(
              'assets/images/avatar.png',
              fit: BoxFit.cover,
            ),
          ),
        )
      ]),
    );
  }
}
