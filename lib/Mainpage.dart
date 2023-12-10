import 'package:flutter/material.dart';
import 'Todo.dart';

class mainPage extends StatefulWidget {
  const mainPage({super.key});

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  String searchbar = '';

  void updatelist() async {
    await Todo.readcards();
    if (searchbar.trim().isNotEmpty) {
      setState(() {
        todolist = Todo.tolist
            .where((element) => element.prio == int.parse(searchbar))
            .toList();
      });
    } else {
      setState(() {
        todolist = Todo.tolist;
      });
    }
  }

  @override
  void initState() {
    Todo.readcards();
    updatelist();
    super.initState();
  }

  List<Todo> todolist = [];
  Todo thandler = Todo();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Main page")),
      body: Column(children: [
        TextFormField(
          decoration: const InputDecoration(hintText: 'priority'),
          keyboardType: TextInputType.number,
          autocorrect: false,
          onChanged: (value) {
            searchbar = value;
            updatelist();
          },
        ),
        SizedBox(
          height: 300,
          child: ListView.builder(
            itemCount: todolist.length,
            itemBuilder: (context, index) {
              return ListTile(
                key: Key(todolist[index].id),
                title: Text("${todolist[index].item}"),
                trailing: Text("priority: ${todolist[index].prio}"),
                leading: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    await thandler.delete(todolist[index].id);
                    updatelist();
                  },
                ),
              );
            },
          ),
        )
      ]),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.pushNamed(context, '/AddPage')
                .then((value) => updatelist());
          },
          child: const Icon(Icons.add)),
    );
  }
}
