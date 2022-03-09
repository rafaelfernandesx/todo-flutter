import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_app_mobx/models/todo.model.dart';
import 'package:todo_app_mobx/stores/todo.store.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

final todoStore = TodoStore();

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Observer(
          builder: (_) => Text(
            todoStore.todos.length.toString(),
          ),
        ),
      ),
      body: Container(
        child: Observer(
          builder: (_) => ListView.builder(
            itemCount: todoStore.todos.length,
            itemBuilder: (context, index) {
              var todo = todoStore.todos[index];
              return Text(todo.title);
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var todo = Todo('title', false);
          todoStore.add(todo);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
