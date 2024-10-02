import 'package:flutter/material.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final List<String> _todos = []; // List to store the to-do items
  final TextEditingController _textController = TextEditingController(); // Controller for input field

  // Method to handle adding a new to-do
  void _addTodo() {
    if (_textController.text.isNotEmpty) {
      setState(() {
        _todos.add(_textController.text); // Add new to-do to the list
        _textController.clear(); // Clear the input field after adding
      });
    }
  }

  // Method to handle deleting a to-do
  void _deleteTodo(int index) {
    setState(() {
      _todos.removeAt(index); // Remove to-do by index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      labelText: 'Enter a task',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _addTodo,
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
          Expanded(
            child: _todos.isEmpty
                ? const Center(child: Text('No tasks yet!'))
                : ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: ListTile(
                    title: Text(_todos[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteTodo(index),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
