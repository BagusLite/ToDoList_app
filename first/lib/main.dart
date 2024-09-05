import 'package:flutter/material.dart';

void main() => runApp(MyApp());

// Widget utama aplikasi
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: Colors.blue
      ),
      home: MyHomePage(),
    );
  }
}

// Halaman utama aplikasi
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// State dari halaman utama
class _MyHomePageState extends State<MyHomePage> {
  // Daftar untuk menyimpan item to-do
  List<String> _todoItems = [];

  // Controller untuk TextField
  TextEditingController _textFieldController = TextEditingController();

  // Fungsi untuk menambah item to-do
  void _addTodoItem(String task) {
    if (task.length > 0) {
      setState(() {
        _todoItems.add(task);
      });
      _textFieldController.clear();
    }
  }

  // Menampilkan dialog untuk menambah item baru
  void _displayAddTodoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tambah Tugas Baru'),
          content: TextField(
            controller: _textFieldController,
            autofocus: true,
            decoration: InputDecoration(hintText: 'Masukkan tugas...'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Tambah'),
              onPressed: () {
                _addTodoItem(_textFieldController.text);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                _textFieldController.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Membuat widget untuk setiap item to-do
  Widget _buildTodoItem(String todoText, int index) {
    return ListTile(
      title: Text(todoText),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () => _removeTodoItem(index),
      ),
    );
  }

  // Menghapus item to-do
  void _removeTodoItem(int index) {
    setState(() {
      _todoItems.removeAt(index);
    });
  }

  // Membangun daftar to-do
  Widget _buildTodoList() {
    return ListView.builder(
      itemCount: _todoItems.length,
      itemBuilder: (context, index) {
        return _buildTodoItem(_todoItems[index], index);
      },
    );
  }

  // Membangun UI aplikasi
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List Sederhana'),
      ),
      body: _buildTodoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _displayAddTodoDialog,
        tooltip: 'Tambah Tugas',
        child: Icon(Icons.add),
      ),
    );
  }
}